import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showMonthly = true;

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
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(label: Text('Monthly'), value: true),
              ButtonSegment(label: Text('Yearly'), value: false),
            ],
            selected: {_showMonthly},
            onSelectionChanged: (Set<bool> newSelection) {
              setState(() => _showMonthly = newSelection.first);
            },
          ),
          const SizedBox(height: 24),
          Consumer<TransactionProvider>(
            builder: (context, provider, _) {
              final now = DateTime.now();
              final summary = _showMonthly
                  ? provider.calculateSummary(
                      from: DateTime(now.year, now.month, 1),
                      to: DateTime(now.year, now.month + 1, 0),
                    )
                  : provider.calculateSummary(
                      from: DateTime(now.year, 1, 1),
                      to: DateTime(now.year, 12, 31),
                    );

              return Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _StatRow(
                            label: 'Total Income',
                            value: 'Tk ${summary.totalIncome.toStringAsFixed(2)}',
                            color: Colors.green,
                          ),
                          const Divider(),
                          _StatRow(
                            label: 'Total Expenses',
                            value: 'Tk ${summary.totalExpenses.toStringAsFixed(2)}',
                            color: Colors.red,
                          ),
                          const Divider(),
                          _StatRow(
                            label: 'Balance',
                            value: 'Tk ${summary.balance.toStringAsFixed(2)}',
                            color: summary.balance >= 0 ? Colors.green : Colors.red,
                          ),
                          const Divider(),
                          _StatRow(
                            label: 'Savings Rate',
                            value: '${summary.savingsRate.toStringAsFixed(1)}%',
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Accounts',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.accounts.length,
                    itemBuilder: (context, index) {
                      final account = provider.accounts[index];
                      final balance = provider.getAccountBalance(account.id);
                      return Card(
                        child: ListTile(
                          leading: Text(account.emoji, style: const TextStyle(fontSize: 24)),
                          title: Text(account.name),
                          trailing: Text(
                            'Tk $balance',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ];
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
