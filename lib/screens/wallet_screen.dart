import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../theme/app_theme.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String _filterCategory = 'All';
  String _sortBy = 'date';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkGreen,
      appBar: AppBar(
        backgroundColor: AppTheme.darkGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
            color: AppTheme.textWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppTheme.neonGreen),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          final expenses = _getFilteredExpenses(provider.expenses);
          final totalSpent = expenses.fold(0.0, (sum, e) => sum + e.amount);

          return Column(
            children: [
              // Balance Card
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonGreen,
                      AppTheme.neonGreen.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Balance',
                          style: TextStyle(
                            color: AppTheme.darkGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.darkGreen.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet,
                            color: AppTheme.darkGreen,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '\$${(1000 - totalSpent).toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppTheme.darkGreen,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Income',
                                style: TextStyle(
                                  color: AppTheme.darkGreen,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '\$1,000.00',
                                style: TextStyle(
                                  color: AppTheme.darkGreen,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppTheme.darkGreen.withOpacity(0.3),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Expenses',
                                style: TextStyle(
                                  color: AppTheme.darkGreen,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${totalSpent.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: AppTheme.darkGreen,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Transactions Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Transactions',
                      style: TextStyle(
                        color: AppTheme.textWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${expenses.length} total',
                      style: const TextStyle(
                        color: AppTheme.textGray,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Transactions List
              Expanded(
                child: expenses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 64,
                              color: AppTheme.textGray.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No transactions yet',
                              style: TextStyle(
                                color: AppTheme.textGray,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          final expense = expenses[index];
                          final category = provider.categories.firstWhere(
                            (c) => c.id == expense.categoryId,
                            orElse: () => provider.categories.first,
                          );

                          return _buildTransactionItem(
                            expense,
                            category.name,
                            provider,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_expense');
        },
        backgroundColor: AppTheme.neonGreen,
        elevation: 8,
        child: const Icon(Icons.add, color: AppTheme.darkGreen, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(context, 2),
    );
  }

  Widget _buildTransactionItem(Expense expense, String categoryName, ExpenseProvider provider) {
    IconData icon;
    Color color;

    switch (categoryName) {
      case 'Food':
        icon = Icons.restaurant;
        color = AppTheme.foodOrange;
        break;
      case 'Transport':
        icon = Icons.directions_bus;
        color = AppTheme.transportBlue;
        break;
      case 'Entertainment':
        icon = Icons.movie;
        color = AppTheme.entertainmentPurple;
        break;
      default:
        icon = Icons.shopping_bag;
        color = AppTheme.booksBlue;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkGreenCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          expense.payee,
          style: const TextStyle(
            color: AppTheme.textWhite,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              categoryName,
              style: const TextStyle(
                color: AppTheme.textGray,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              DateFormat('MMM dd, yyyy • h:mm a').format(expense.date),
              style: const TextStyle(
                color: AppTheme.textGray,
                fontSize: 11,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '-\$${expense.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppTheme.textWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (expense.note.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.neonGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.note,
                  size: 12,
                  color: AppTheme.neonGreen,
                ),
              ),
          ],
        ),
        onTap: () {
          _showTransactionDetails(expense, categoryName, icon, color);
        },
      ),
    );
  }

  void _showTransactionDetails(Expense expense, String categoryName, IconData icon, Color color) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkGreenCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 40),
            ),
            const SizedBox(height: 16),
            Text(
              expense.payee,
              style: const TextStyle(
                color: AppTheme.textWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '-\$${expense.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppTheme.neonGreen,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Category', categoryName),
            _buildDetailRow('Date', DateFormat('MMM dd, yyyy').format(expense.date)),
            _buildDetailRow('Time', DateFormat('h:mm a').format(expense.date)),
            if (expense.note.isNotEmpty) _buildDetailRow('Note', expense.note),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Edit functionality
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.neonGreen),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: AppTheme.neonGreen),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<ExpenseProvider>(context, listen: false)
                          .deleteExpense(expense.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.dangerRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textGray,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkGreenCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter & Sort',
              style: TextStyle(
                color: AppTheme.textWhite,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sort By',
              style: TextStyle(
                color: AppTheme.textGray,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                _buildFilterChip('Date', 'date'),
                _buildFilterChip('Amount', 'amount'),
                _buildFilterChip('Category', 'category'),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _sortBy == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _sortBy = value;
          Navigator.pop(context);
        });
      },
      selectedColor: AppTheme.neonGreen,
      backgroundColor: AppTheme.darkGreen,
      labelStyle: TextStyle(
        color: isSelected ? AppTheme.darkGreen : AppTheme.textWhite,
      ),
    );
  }

  List<Expense> _getFilteredExpenses(List<Expense> expenses) {
    var filtered = expenses.toList();

    // Sort
    if (_sortBy == 'date') {
      filtered.sort((a, b) => b.date.compareTo(a.date));
    } else if (_sortBy == 'amount') {
      filtered.sort((a, b) => b.amount.compareTo(a.amount));
    }

    return filtered;
  }

  Widget _buildBottomNav(BuildContext context, int currentIndex) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkGreenCard,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0, currentIndex, () {
                Navigator.pushReplacementNamed(context, '/');
              }),
              _buildNavItem(Icons.pie_chart, 'Budget', 1, currentIndex, () {
                Navigator.pushReplacementNamed(context, '/budget');
              }),
              const SizedBox(width: 60),
              _buildNavItem(Icons.account_balance_wallet, 'Wallet', 2, currentIndex, () {
                // Already on wallet
              }),
              _buildNavItem(Icons.person, 'Profile', 3, currentIndex, () {
                Navigator.pushNamed(context, '/profile');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, int currentIndex, VoidCallback onTap) {
    final isActive = index == currentIndex;
    
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppTheme.neonGreen : AppTheme.textGray,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppTheme.neonGreen : AppTheme.textGray,
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
