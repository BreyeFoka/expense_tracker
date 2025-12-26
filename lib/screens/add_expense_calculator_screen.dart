import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AddExpenseCalculatorScreen extends StatefulWidget {
  const AddExpenseCalculatorScreen({super.key});

  @override
  State<AddExpenseCalculatorScreen> createState() => _AddExpenseCalculatorScreenState();
}

class _AddExpenseCalculatorScreenState extends State<AddExpenseCalculatorScreen> {
  String _amount = '0';
  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();
  String _note = '';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Food', 'icon': Icons.restaurant, 'color': AppTheme.foodOrange},
    {'name': 'Transport', 'icon': Icons.directions_bus, 'color': AppTheme.transportBlue},
    {'name': 'Shopping', 'icon': Icons.shopping_bag, 'color': AppTheme.shoppingPink},
    {'name': 'Entertainment', 'icon': Icons.movie, 'color': AppTheme.entertainmentPurple},
    {'name': 'Bills', 'icon': Icons.receipt_long, 'color': AppTheme.billsYellow},
  ];

  void _onNumberTap(String value) {
    setState(() {
      if (_amount == '0') {
        _amount = value;
      } else {
        _amount += value;
      }
    });
  }

  void _onDecimalTap() {
    setState(() {
      if (!_amount.contains('.')) {
        _amount += '.';
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (_amount.length > 1) {
        _amount = _amount.substring(0, _amount.length - 1);
      } else {
        _amount = '0';
      }
    });
  }

  void _onClear() {
    setState(() {
      _amount = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkGreen,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppTheme.textWhite, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Add Expense',
                    style: AppTheme.headingMedium.copyWith(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: _onClear,
                    child: Text(
                      'Clear',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textGray,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Amount Display
            Column(
              children: [
                Text(
                  '\$$_amount',
                  style: TextStyle(
                    color: AppTheme.neonGreen,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'USD',
                  style: AppTheme.bodyMedium.copyWith(
                    fontSize: 16,
                    color: AppTheme.textGray,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.receipt_long_outlined,
                      label: 'Scan\nReceipt',
                      color: AppTheme.neonGreen,
                      onTap: () => Navigator.pushNamed(context, '/scan_receipt'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildQuickActionButton(
                      icon: Icons.message,
                      label: 'MoMo\nPaste SMS',
                      color: AppTheme.transportBlue,
                      onTap: () => Navigator.pushNamed(context, '/import_momo'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Category Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category',
                        style: AppTheme.labelMedium,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Edit',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.neonGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategory == category['name'];
                        return _buildCategoryChip(
                          category['name'],
                          category['icon'],
                          isSelected,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Date Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() => _selectedDate = date);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.darkGreenCard,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: AppTheme.textGray, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        _selectedDate.day == DateTime.now().day
                            ? 'Today, Oct 24'
                            : '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
                        style: AppTheme.bodyLarge,
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, color: AppTheme.textGray, size: 16),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Note Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.darkGreenCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined, color: AppTheme.textGray, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        style: AppTheme.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Add a note...',
                          hintStyle: AppTheme.bodyMedium,
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) => _note = value,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Number Pad
            _buildNumberPad(),

            const SizedBox(height: 16),

            // Add Expense Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _amount != '0' ? () {
                    // Add expense logic
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Expense added successfully!'),
                        backgroundColor: AppTheme.successGreen,
                      ),
                    );
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.neonGreen,
                    foregroundColor: AppTheme.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check, color: AppTheme.black),
                      const SizedBox(width: 8),
                      Text(
                        'Add Expense',
                        style: AppTheme.buttonText,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: AppTheme.darkGreenCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textWhite,
                fontSize: 13,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String name, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.neonGreen : AppTheme.darkGreenCard,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.black : AppTheme.textGray,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? AppTheme.black : AppTheme.textWhite,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildNumberRow(['1', '2', '3']),
          const SizedBox(height: 12),
          _buildNumberRow(['4', '5', '6']),
          const SizedBox(height: 12),
          _buildNumberRow(['7', '8', '9']),
          const SizedBox(height: 12),
          _buildNumberRow(['.', '0', 'back']),
        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((num) => _buildNumberButton(num)).toList(),
    );
  }

  Widget _buildNumberButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GestureDetector(
          onTap: () {
            if (value == 'back') {
              _onBackspace();
            } else if (value == '.') {
              _onDecimalTap();
            } else {
              _onNumberTap(value);
            }
          },
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: AppTheme.darkGreenCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: value == 'back'
                  ? const Icon(Icons.backspace_outlined, color: AppTheme.textWhite, size: 24)
                  : Text(
                      value,
                      style: const TextStyle(
                        color: AppTheme.textWhite,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
