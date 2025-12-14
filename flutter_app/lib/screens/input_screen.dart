import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_form.dart';
import '../widgets/summary_cards.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Consumer<TransactionProvider>(
            builder: (context, provider, _) {
              final summary = provider.calculateSummary();
              return SummaryCards(summary: summary);
            },
          ),
          const SizedBox(height: 32),
          Text(
            'Add Transaction',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const TransactionForm(),
        ],
      ),
    );
  }
}
