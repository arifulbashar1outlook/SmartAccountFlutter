import 'package:flutter/foundation.dart';
import '../models/types.dart';
import '../services/storage_service.dart';
import 'package:uuid/uuid.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];
  List<Account> _accounts = [];

  List<Transaction> get transactions => _transactions;
  List<Account> get accounts => _accounts;

  TransactionProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _transactions = await StorageService.getTransactions();
    _accounts = await StorageService.getAccounts();
    notifyListeners();
  }

  Future<void> addTransaction({
    required double amount,
    required TransactionType type,
    required String category,
    required String description,
    required String accountId,
    String? targetAccountId,
  }) async {
    final transaction = Transaction(
      id: const Uuid().v4(),
      amount: amount,
      type: type,
      category: category,
      description: description,
      date: DateTime.now(),
      accountId: accountId,
      targetAccountId: targetAccountId,
    );

    _transactions.add(transaction);
    await StorageService.saveTransactions(_transactions);
    notifyListeners();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
      await StorageService.saveTransactions(_transactions);
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((t) => t.id == id);
    await StorageService.saveTransactions(_transactions);
    notifyListeners();
  }

  Future<void> addAccount(String name, String emoji) async {
    final account = Account(
      id: const Uuid().v4(),
      name: name,
      emoji: emoji,
    );
    _accounts.add(account);
    await StorageService.saveAccounts(_accounts);
    notifyListeners();
  }

  Future<void> updateAccount(Account account) async {
    final index = _accounts.indexWhere((a) => a.id == account.id);
    if (index != -1) {
      _accounts[index] = account;
      await StorageService.saveAccounts(_accounts);
      notifyListeners();
    }
  }

  Future<void> deleteAccount(String id) async {
    _accounts.removeWhere((a) => a.id == id);
    await StorageService.saveAccounts(_accounts);
    notifyListeners();
  }

  List<Transaction> getTransactionsByMonth(int month, int year) {
    return _transactions.where((t) {
      return t.date.month == month && t.date.year == year;
    }).toList();
  }

  List<Transaction> getTransactionsByCategory(String category) {
    return _transactions.where((t) => t.category == category).toList();
  }

  FinancialSummary calculateSummary({DateTime? from, DateTime? to}) {
    final filtered = _transactions.where((t) {
      if (from != null && t.date.isBefore(from)) return false;
      if (to != null && t.date.isAfter(to)) return false;
      return true;
    }).toList();

    double income = 0, expenses = 0;
    
    for (var t in filtered) {
      if (t.type == TransactionType.income) {
        income += t.amount;
      } else if (t.type == TransactionType.expense) {
        expenses += t.amount;
      }
    }

    final balance = income - expenses;
    final savingsRate = income > 0 ? (balance / income) * 100 : 0;

    return FinancialSummary(
      totalIncome: income,
      totalExpenses: expenses,
      balance: balance,
      savingsRate: savingsRate,
    );
  }

  double getAccountBalance(String accountId) {
    double balance = 0;
    for (var t in _transactions) {
      if (t.accountId == accountId) {
        if (t.type == TransactionType.income) {
          balance += t.amount;
        } else if (t.type == TransactionType.expense) {
          balance -= t.amount;
        }
      }
      if (t.targetAccountId == accountId && t.type == TransactionType.transfer) {
        balance += t.amount;
      }
    }
    return balance;
  }
}
