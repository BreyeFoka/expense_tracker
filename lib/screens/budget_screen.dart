import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final Map<String, double> _budgets = {
    '1': 500.0, // Food
    '2': 200.0, // Transport
    '3': 150.0, // Entertainment
    '4': 300.0, // Office
    '5': 100.0, // Gym
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget'),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          final currentMonth = DateTime.now();
          final monthStart = DateTime(currentMonth.year, currentMonth.month, 1);
          final monthEnd =
              DateTime(currentMonth.year, currentMonth.month + 1, 0);

          final monthExpenses = provider.expenses
              .where((e) =>
                  e.date.isAfter(monthStart) &&
                  e.date.isBefore(monthEnd.add(const Duration(days: 1))))
              .toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall Budget Summary
                  _buildOverallSummary(monthExpenses),
                  const SizedBox(height: 20),

                  const Text(
                    'Budget by Category',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Category Budgets
                  ...provider.categories.map((category) {
                    final categoryExpenses = monthExpenses
                        .where((e) => e.categoryId == category.id)
                        .toList();
                    final spent =
                        categoryExpenses.fold(0.0, (sum, e) => sum + e.amount);
                    final budget = _budgets[category.id] ?? 0.0;

                    return _buildBudgetCard(
                      category.name,
                      budget,
                      spent,
                      category.id,
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverallSummary(List<Expense> expenses) {
    final totalBudget = _budgets.values.fold(0.0, (sum, b) => sum + b);
    final totalSpent = expenses.fold(0.0, (sum, e) => sum + e.amount);
    final remaining = totalBudget - totalSpent;
    final percentage = totalBudget > 0 ? (totalSpent / totalBudget) * 100 : 0.0;

    return Card(
      elevation: 4,
      color: remaining >= 0 ? Colors.green[50] : Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Monthly Budget Overview',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryColumn(
                    'Budget', '\$${totalBudget.toStringAsFixed(2)}'),
                _buildSummaryColumn(
                    'Spent', '\$${totalSpent.toStringAsFixed(2)}'),
                _buildSummaryColumn(
                  'Remaining',
                  '\$${remaining.toStringAsFixed(2)}',
                  color: remaining >= 0 ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: (percentage / 100).clamp(0.0, 1.0),
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: percentage > 100
                          ? Colors.red
                          : percentage > 80
                              ? Colors.orange
                              : Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${percentage.toStringAsFixed(1)}% used',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryColumn(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.indigoAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetCard(
    String categoryName,
    double budget,
    double spent,
    String categoryId,
  ) {
    final remaining = budget - spent;
    final percentage = budget > 0 ? (spent / budget) * 100 : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () =>
                      _editBudget(categoryId, categoryName, budget),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spent: \$${spent.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'Budget: \$${budget.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: (percentage / 100).clamp(0.0, 1.0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: percentage > 100
                          ? Colors.red
                          : percentage > 80
                              ? Colors.orange
                              : Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              remaining >= 0
                  ? '\$${remaining.toStringAsFixed(2)} remaining'
                  : '\$${(-remaining).toStringAsFixed(2)} over budget',
              style: TextStyle(
                fontSize: 12,
                color: remaining >= 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editBudget(
      String categoryId, String categoryName, double currentBudget) {
    final controller = TextEditingController(text: currentBudget.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Budget for $categoryName'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Budget Amount',
            prefixText: '\$',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newBudget = double.tryParse(controller.text);
              if (newBudget != null && newBudget >= 0) {
                setState(() {
                  _budgets[categoryId] = newBudget;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
