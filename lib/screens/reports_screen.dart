import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String _groupBy = 'Category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          final filteredExpenses = provider.expenses
              .where((expense) =>
                  expense.date.isAfter(_startDate) &&
                  expense.date.isBefore(_endDate.add(const Duration(days: 1))))
              .toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Range Selector
                  _buildDateRangeSelector(),
                  const SizedBox(height: 20),

                  // Group By Selector
                  _buildGroupBySelector(),
                  const SizedBox(height: 20),

                  // Summary Card
                  _buildSummaryCard(filteredExpenses),
                  const SizedBox(height: 20),

                  // Report Details
                  const Text(
                    'Detailed Report',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (_groupBy == 'Category')
                    ..._buildCategoryReport(filteredExpenses, provider)
                  else if (_groupBy == 'Tag')
                    ..._buildTagReport(filteredExpenses, provider)
                  else
                    ..._buildDateReport(filteredExpenses),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDateButton(
                    'From',
                    _startDate,
                    (date) => setState(() => _startDate = date),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDateButton(
                    'To',
                    _endDate,
                    (date) => setState(() => _endDate = date),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateButton(
    String label,
    DateTime date,
    Function(DateTime) onDateSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(DateFormat('MMM dd, yyyy').format(date)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupBySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigoAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Text('Group by: '),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _groupBy,
                items: ['Category', 'Tag', 'Date']
                    .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _groupBy = value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(List<Expense> expenses) {
    final total = expenses.fold(0.0, (sum, e) => sum + e.amount);
    final count = expenses.length;
    final average = count > 0 ? total / count : 0.0;

    return Card(
      elevation: 4,
      color: Colors.purple[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem('Total', '\$${total.toStringAsFixed(2)}'),
            _buildSummaryItem('Count', count.toString()),
            _buildSummaryItem('Average', '\$${average.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigoAccent,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCategoryReport(
    List<Expense> expenses,
    ExpenseProvider provider,
  ) {
    final Map<String, List<Expense>> grouped = {};

    for (var expense in expenses) {
      grouped.putIfAbsent(expense.categoryId, () => []).add(expense);
    }

    return grouped.entries.map((entry) {
      final category = provider.categories.firstWhere((c) => c.id == entry.key,
          orElse: () => provider.categories.first);
      final total = entry.value.fold(0.0, (sum, e) => sum + e.amount);

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ExpansionTile(
          title: Text(category.name),
          subtitle: Text('${entry.value.length} transactions'),
          trailing: Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          children: entry.value.map((expense) {
            return ListTile(
              dense: true,
              title: Text(expense.payee),
              subtitle: Text(DateFormat('MMM dd, yyyy').format(expense.date)),
              trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  List<Widget> _buildTagReport(
    List<Expense> expenses,
    ExpenseProvider provider,
  ) {
    final Map<String, List<Expense>> grouped = {};

    for (var expense in expenses) {
      grouped.putIfAbsent(expense.tag, () => []).add(expense);
    }

    return grouped.entries.map((entry) {
      final tag = provider.tags.firstWhere((t) => t.id == entry.key,
          orElse: () => provider.tags.first);
      final total = entry.value.fold(0.0, (sum, e) => sum + e.amount);

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ExpansionTile(
          title: Text(tag.name),
          subtitle: Text('${entry.value.length} transactions'),
          trailing: Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          children: entry.value.map((expense) {
            return ListTile(
              dense: true,
              title: Text(expense.payee),
              subtitle: Text(DateFormat('MMM dd, yyyy').format(expense.date)),
              trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  List<Widget> _buildDateReport(List<Expense> expenses) {
    final Map<String, List<Expense>> grouped = {};

    for (var expense in expenses) {
      final dateKey = DateFormat('yyyy-MM-dd').format(expense.date);
      grouped.putIfAbsent(dateKey, () => []).add(expense);
    }

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return sortedKeys.map((dateKey) {
      final dateExpenses = grouped[dateKey]!;
      final total = dateExpenses.fold(0.0, (sum, e) => sum + e.amount);
      final date = DateTime.parse(dateKey);

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ExpansionTile(
          title: Text(DateFormat('EEEE, MMM dd, yyyy').format(date)),
          subtitle: Text('${dateExpenses.length} transactions'),
          trailing: Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          children: dateExpenses.map((expense) {
            return ListTile(
              dense: true,
              title: Text(expense.payee),
              subtitle: Text(expense.note),
              trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
            );
          }).toList(),
        ),
      );
    }).toList();
  }
}
