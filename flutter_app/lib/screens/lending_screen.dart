import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../providers/transaction_provider.dart';

class LendingScreen extends StatefulWidget {
  const LendingScreen({Key? key}) : super(key: key);

  @override
  State<LendingScreen> createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen> {
  String? _selectedPerson;
  final TextEditingController _personController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _personController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  List<String> _getLendingPeople() {
    final provider = context.read<TransactionProvider>();
    final lendingTransactions = provider.transactions
        .where((t) => t.category == Category.lending)
        .toList();
    
    return {...lendingTransactions.map((t) => t.description).toSet()}.toList();
  }

  void _addLendingRecord(bool isLend) {
    final amount = double.tryParse(_amountController.text.trim());
    final person = _selectedPerson;

    if (amount == null || amount <= 0 || person == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final provider = context.read<TransactionProvider>();
    provider.addTransaction(
      amount: amount,
      type: TransactionType.expense,
      category: Category.lending,
      description: person,
      accountId: 'cash',
    );

    _amountController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${isLend ? 'Lent' : 'Received'} from $person')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lending Manager',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _personController,
                    decoration: InputDecoration(
                      labelText: 'Person name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount (Tk)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[300],
                          ),
                          onPressed: () => _addLendingRecord(true),
                          child: const Text('Lend'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[300],
                          ),
                          onPressed: () => _addLendingRecord(false),
                          child: const Text('Receive'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Lending Records',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Consumer<TransactionProvider>(
            builder: (context, provider, _) {
              final people = _getLendingPeople();
              
              if (people.isEmpty) {
                return Center(
                  child: Text(
                    'No lending records yet',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: people.length,
                itemBuilder: (context, index) {
                  final person = people[index];
                  final personTransactions = provider.transactions
                      .where((t) => t.category == Category.lending && t.description == person)
                      .toList();
                  
                  final total = personTransactions.fold<double>(
                    0,
                    (sum, t) => sum + t.amount,
                  );

                  return Card(
                    child: ListTile(
                      title: Text(person),
                      subtitle: Text('${personTransactions.length} transaction(s)'),
                      trailing: Text(
                        'Tk $total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: total > 0 ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
