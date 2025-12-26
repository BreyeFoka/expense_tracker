import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppTheme.darkGreenCard,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context,
              Icons.home,
              'Home',
              0,
              currentIndex,
              () => Navigator.pushReplacementNamed(context, '/'),
            ),
            _buildNavItem(
              context,
              Icons.bar_chart,
              'Insights',
              1,
              currentIndex,
              () => Navigator.pushReplacementNamed(context, '/statistics'),
            ),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(
              context,
              Icons.account_balance_wallet,
              'Wallet',
              2,
              currentIndex,
              () => Navigator.pushReplacementNamed(context, '/wallet'),
            ),
            _buildNavItem(
              context,
              Icons.person,
              'Profile',
              3,
              currentIndex,
              () => Navigator.pushReplacementNamed(context, '/profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    int currentIndex,
    VoidCallback onTap,
  ) {
    final isActive = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      ),
    );
  }
}

class AppFAB extends StatelessWidget {
  const AppFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddExpenseOptions(context),
      backgroundColor: AppTheme.neonGreen,
      child: const Icon(Icons.add, color: AppTheme.darkGreen, size: 32),
    );
  }

  void _showAddExpenseOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkGreenCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Expense',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildOptionTile(
              context,
              Icons.keyboard,
              'Manual Entry',
              'Enter expense details manually',
              () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/add_expense');
              },
            ),
            _buildOptionTile(
              context,
              Icons.camera_alt,
              'Scan Receipt',
              'Capture receipt with camera',
              () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/scan_receipt');
              },
            ),
            _buildOptionTile(
              context,
              Icons.message,
              'Import from MoMo',
              'Import from SMS message',
              () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/import_momo');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.darkGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.neonGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.neonGreen, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
