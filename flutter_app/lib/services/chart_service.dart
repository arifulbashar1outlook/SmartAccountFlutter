import 'package:flutter/foundation.dart';
import '../models/types.dart';

class FinancialChartData {
  final String label;
  final double value;
  final String? account;

  FinancialChartData({
    required this.label,
    required this.value,
    this.account,
  });
}

class ChartService {
  static List<FinancialChartData> getCategoryBreakdown(List<Transaction> transactions) {
    final Map<String, double> breakdown = {};
    
    for (var tx in transactions) {
      if (tx.type == TransactionType.expense) {
        breakdown[tx.category] = (breakdown[tx.category] ?? 0) + tx.amount;
      }
    }

    return breakdown.entries
        .map((e) => FinancialChartData(label: e.key, value: e.value))
        .toList();
  }

  static List<FinancialChartData> getAccountBreakdown(
    List<Transaction> transactions,
    List<Account> accounts,
  ) {
    final Map<String, double> breakdown = {};

    for (var account in accounts) {
      double balance = 0;
      for (var tx in transactions) {
        if (tx.accountId == account.id) {
          if (tx.type == TransactionType.income) {
            balance += tx.amount;
          } else if (tx.type == TransactionType.expense) {
            balance -= tx.amount;
          }
        }
      }
      breakdown[account.name] = balance;
    }

    return breakdown.entries
        .map((e) => FinancialChartData(label: e.key, value: e.value))
        .toList();
  }

  static List<FinancialChartData> getMonthlyTrend(List<Transaction> transactions) {
    final Map<String, double> trend = {};

    for (var tx in transactions) {
      final key = '${tx.date.year}-${tx.date.month.toString().padLeft(2, '0')}';
      double amount = tx.amount;
      if (tx.type == TransactionType.expense) {
        amount = -amount;
      }
      trend[key] = (trend[key] ?? 0) + amount;
    }

    return trend.entries
        .map((e) => FinancialChartData(label: e.key, value: e.value))
        .toList();
  }
}
