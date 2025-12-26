import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AddExpenseModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.92,
        decoration: const BoxDecoration(
          color: AppTheme.darkGreen,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textGray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Close button row
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppTheme.textWhite),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Add Transaction',
                    style: AppTheme.headingMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(width: 48), // Balance for close button
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Options
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _buildOptionCard(
                    context,
                    icon: Icons.edit_outlined,
                    title: 'Manual Entry',
                    subtitle: 'Enter expense details manually',
                    color: AppTheme.neonGreen,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/add_expense');
                    },
                  ),

                  const SizedBox(height: 16),

                  _buildOptionCard(
                    context,
                    icon: Icons.receipt_long_outlined,
                    title: 'Scan Receipt',
                    subtitle: 'Take a photo of your receipt',
                    color: AppTheme.transportBlue,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/scan_receipt');
                    },
                  ),

                  const SizedBox(height: 16),

                  _buildOptionCard(
                    context,
                    icon: Icons.message_outlined,
                    title: 'Import from MoMo',
                    subtitle: 'Paste transaction SMS',
                    color: AppTheme.entertainmentPurple,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/import_momo');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.darkGreenCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTheme.bodyMedium.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.textGray,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
