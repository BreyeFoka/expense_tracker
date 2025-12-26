import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../theme/app_theme.dart';

class NewAddExpenseScreen extends StatefulWidget {
  const NewAddExpenseScreen({super.key});

  @override
  State<NewAddExpenseScreen> createState() => _NewAddExpenseScreenState();
}

class _NewAddExpenseScreenState extends State<NewAddExpenseScreen> {
  String _amount = '0';
  String _selectedCategory = 'Food';
  String? _selectedCategoryId = '1';
  DateTime _selectedDate = DateTime.now();
  String _note = '';

  void _onNumberPressed(String number) {
    setState(() {
      if (_amount == '0') {
        _amount = number;
      } else {
        _amount += number;
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (!_amount.contains('.')) {
        _amount += '.';
      }
    });
  }

  void _onBackspacePressed() {
    setState(() {
      if (_amount.length > 1) {
        _amount = _amount.substring(0, _amount.length - 1);
      } else {
        _amount = '0';
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _amount = '0';
    });
  }

  void _saveExpense() {
    if (_amount == '0' || _amount.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an amount'),
          backgroundColor: AppTheme.dangerRed,
        ),
      );
      return;
    }

    final provider = Provider.of<ExpenseProvider>(context, listen: false);
    final expense = Expense(
      id: DateTime.now().toString(),
      amount: double.parse(_amount),
      categoryId: _selectedCategoryId!,
      payee: _selectedCategory,
      note: _note,
      date: _selectedDate,
      tag: '1', // Default tag
    );

    provider.addExpense(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkGreen,
      appBar: AppBar(
        backgroundColor: AppTheme.darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.textWhite, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Expense',
          style: TextStyle(
            color: AppTheme.textWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _onClearPressed,
            child: const Text(
              'Clear',
              style: TextStyle(
                color: AppTheme.textGray,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // Amount Display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '\$',
                        style: TextStyle(
                          color: AppTheme.textGray,
                          fontSize: 48,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _amount,
                        style: const TextStyle(
                          color: AppTheme.neonGreen,
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'USD',
                    style: TextStyle(
                      color: AppTheme.textGray,
                      fontSize: 14,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Scan Receipt & MoMo Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          'Scan\nReceipt',
                          Icons.qr_code_scanner,
                          AppTheme.neonGreen,
                          () {},
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildActionButton(
                          'MoMo\nPaste SMS',
                          Icons.message,
                          AppTheme.transportBlue,
                          () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Category Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(
                          color: AppTheme.textWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/manage_categories');
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                            color: AppTheme.neonGreen,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Category Chips
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildCategoryChip('Food', '1', Icons.restaurant),
                      _buildCategoryChip(
                          'Transport', '2', Icons.directions_bus),
                      _buildCategoryChip('Shopping', '3', Icons.shopping_bag),
                      _buildCategoryChip('Entertainment', '4', Icons.movie),
                      _buildCategoryChip('Health', '5', Icons.local_hospital),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Date Selector
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.darkGreenCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: AppTheme.textGray,
                          size: 22,
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Date',
                          style: TextStyle(
                            color: AppTheme.textWhite,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.dark().copyWith(
                                    colorScheme: const ColorScheme.dark(
                                      primary: AppTheme.neonGreen,
                                      surface: AppTheme.darkGreenCard,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              setState(() => _selectedDate = picked);
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                DateFormat('Today, MMM dd')
                                    .format(_selectedDate),
                                style: const TextStyle(
                                  color: AppTheme.textGray,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.chevron_right,
                                color: AppTheme.textGray,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Add Note
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.darkGreenCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.note_alt_outlined,
                          color: AppTheme.textGray,
                          size: 22,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: AppTheme.textWhite),
                            decoration: const InputDecoration(
                              hintText: 'Add a note...',
                              hintStyle: TextStyle(color: AppTheme.textGray),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() => _note = value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // Calculator Numpad
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: AppTheme.darkGreen,
            ),
            child: Column(
              children: [
                _buildNumpadRow(['1', '2', '3']),
                const SizedBox(height: 15),
                _buildNumpadRow(['4', '5', '6']),
                const SizedBox(height: 15),
                _buildNumpadRow(['7', '8', '9']),
                const SizedBox(height: 15),
                _buildNumpadRow(['.', '0', '⌫']),
              ],
            ),
          ),

          // Add Expense Button
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.neonGreen,
                  foregroundColor: AppTheme.darkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Add Expense',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.darkGreenCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textWhite,
                fontSize: 13,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, String id, IconData icon) {
    final isSelected = _selectedCategoryId == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryId = id;
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.neonGreen : AppTheme.darkGreenCard,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.darkGreen : AppTheme.textWhite,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.darkGreen : AppTheme.textWhite,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumpadRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildNumpadButton(number),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNumpadButton(String value) {
    return GestureDetector(
      onTap: () {
        if (value == '⌫') {
          _onBackspacePressed();
        } else if (value == '.') {
          _onDecimalPressed();
        } else {
          _onNumberPressed(value);
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppTheme.darkGreenCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
