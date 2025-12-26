import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BudgetPersonalizationScreen extends StatefulWidget {
  const BudgetPersonalizationScreen({super.key});

  @override
  State<BudgetPersonalizationScreen> createState() =>
      _BudgetPersonalizationScreenState();
}

class _BudgetPersonalizationScreenState
    extends State<BudgetPersonalizationScreen> {
  final Map<String, double> categoryBudgets = {
    'Food': 300.00,
    'Transport': 100.00,
    'Entertainment': 150.00,
    'Books': 50.00,
    'Other': 100.00,
  };

  final Map<String, IconData> categoryIcons = {
    'Food': Icons.restaurant,
    'Transport': Icons.directions_car,
    'Entertainment': Icons.movie,
    'Books': Icons.book,
    'Other': Icons.category,
  };

  final Map<String, Color> categoryColors = {
    'Food': const Color(0xFFFF9500),
    'Transport': const Color(0xFF007AFF),
    'Entertainment': const Color(0xFF9747FF),
    'Books': const Color(0xFF34C759),
    'Other': Colors.grey,
  };

  double get totalBudget => categoryBudgets.values.reduce((a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkGreen,
      appBar: AppBar(
        backgroundColor: AppTheme.darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Personalize Your Budget',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepIndicator(1, false),
                _buildStepLine(false),
                _buildStepIndicator(2, true),
                _buildStepLine(false),
                _buildStepIndicator(3, false),
                _buildStepLine(false),
                _buildStepIndicator(4, false),
              ],
            ),
          ),

          // Step Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Step 2 of 4',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Set Category Budgets',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Total Monthly Budget
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.darkGreenCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Monthly Total',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '\$${totalBudget.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppTheme.neonGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Category Budgets List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: categoryBudgets.entries.map((entry) {
                return _buildCategoryBudgetTile(
                  entry.key,
                  entry.value,
                  categoryIcons[entry.key]!,
                  categoryColors[entry.key]!,
                );
              }).toList(),
            ),
          ),

          // Continue Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.darkGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.neonGreen,
                foregroundColor: AppTheme.darkGreen,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, bool isCurrent) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isCurrent ? AppTheme.neonGreen : AppTheme.darkGreenCard,
        shape: BoxShape.circle,
        border: Border.all(
          color: isCurrent ? AppTheme.neonGreen : Colors.grey[700]!,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: isCurrent ? AppTheme.darkGreen : Colors.grey[400],
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? AppTheme.neonGreen : Colors.grey[700],
    );
  }

  Widget _buildCategoryBudgetTile(
      String name, double amount, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGreenCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit, color: AppTheme.neonGreen, size: 20),
            onPressed: () => _showEditBudgetDialog(name, amount),
          ),
        ],
      ),
    );
  }

  void _showEditBudgetDialog(String category, double currentAmount) {
    final controller =
        TextEditingController(text: currentAmount.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.darkGreenCard,
        title: Text(
          'Edit $category Budget',
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixText: '\$ ',
            prefixStyle: const TextStyle(color: AppTheme.neonGreen),
            filled: true,
            fillColor: AppTheme.darkGreen,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                categoryBudgets[category] =
                    double.tryParse(controller.text) ?? currentAmount;
              });
              Navigator.pop(context);
            },
            child:
                const Text('Save', style: TextStyle(color: AppTheme.neonGreen)),
          ),
        ],
      ),
    );
  }
}
