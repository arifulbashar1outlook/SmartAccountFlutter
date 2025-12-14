import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/types.dart';

class StorageService {
  static const String _transactionsKey = 'smartspend_transactions';
  static const String _accountsKey = 'smartspend_accounts';

  static Future<List<Transaction>> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_transactionsKey);
    
    if (jsonString == null) return [];
    
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Transaction.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error loading transactions: $e');
      return [];
    }
  }

  static Future<void> saveTransactions(List<Transaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = transactions.map((t) => t.toJson()).toList();
    await prefs.setString(_transactionsKey, jsonEncode(jsonList));
  }

  static Future<List<Account>> getAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_accountsKey);
    
    if (jsonString == null) {
      // Return default accounts
      return [
        Account(id: 'cash', name: 'Cash', emoji: '💵', isDefault: true),
        Account(id: 'bank', name: 'Bank', emoji: '🏦'),
        Account(id: 'mobile', name: 'Mobile Money', emoji: '📱'),
      ];
    }
    
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Account.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error loading accounts: $e');
      return [];
    }
  }

  static Future<void> saveAccounts(List<Account> accounts) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = accounts.map((a) => a.toJson()).toList();
    await prefs.setString(_accountsKey, jsonEncode(jsonList));
  }
}
