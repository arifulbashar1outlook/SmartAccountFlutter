enum TransactionType { income, expense, transfer }

class Category {
  static const String food = 'Food & Dining';
  static const String bazar = 'Bazar & Groceries';
  static const String transport = 'Transportation';
  static const String utilities = 'Utilities';
  static const String housing = 'Housing';
  static const String entertainment = 'Entertainment';
  static const String shopping = 'Shopping';
  static const String health = 'Health';
  static const String salary = 'Salary';
  static const String investment = 'Investment';
  static const String transfer = 'Transfer';
  static const String lending = 'Lending & Debt';
  static const String sendHome = 'Send Home';
  static const String other = 'Other';

  static List<String> getAll() => [
    food, bazar, transport, utilities, housing, entertainment,
    shopping, health, salary, investment, transfer, lending, sendHome, other
  ];
}

class Transaction {
  final String id;
  final double amount;
  final TransactionType type;
  final String category;
  final String description;
  final DateTime date;
  final String accountId;
  final String? targetAccountId;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.description,
    required this.date,
    required this.accountId,
    this.targetAccountId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'type': type.toString().split('.').last,
    'category': category,
    'description': description,
    'date': date.toIso8601String(),
    'accountId': accountId,
    'targetAccountId': targetAccountId,
  };

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: TransactionType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
        orElse: () => TransactionType.expense,
      ),
      category: json['category'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      accountId: json['accountId'] as String,
      targetAccountId: json['targetAccountId'] as String?,
    );
  }
}

class Account {
  final String id;
  final String name;
  final String emoji;
  final bool isDefault;

  Account({
    required this.id,
    required this.name,
    required this.emoji,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'emoji': emoji,
    'isDefault': isDefault,
  };

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }
}

class FinancialSummary {
  final double totalIncome;
  final double totalExpenses;
  final double balance;
  final double savingsRate;

  FinancialSummary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.balance,
    required this.savingsRate,
  });
}
