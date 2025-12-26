import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          'Profile',
          style: TextStyle(
            color: AppTheme.textWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Picture & Name
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.darkGreenCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.neonGreen, width: 3),
                      color: AppTheme.darkGreen,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: AppTheme.neonGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Alex Johnson',
                    style: TextStyle(
                      color: AppTheme.textWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'alex.johnson@university.edu',
                    style: TextStyle(
                      color: AppTheme.textGray,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_profile');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.neonGreen,
                      foregroundColor: AppTheme.darkGreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Statistics
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('12', 'Days Active'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('48', 'Transactions'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('\$890', 'Total Spent'),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Settings Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Settings',
                style: TextStyle(
                  color: AppTheme.textWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

            _buildSettingItem(
              Icons.notifications_outlined,
              'Notifications',
              'Manage your notifications',
              () {
                Navigator.pushNamed(context, '/notifications_settings');
              },
            ),
            _buildSettingItem(
              Icons.lock_outline,
              'Privacy & Security',
              'Control your data and security',
              () {
                Navigator.pushNamed(context, '/privacy_security');
              },
            ),
            _buildSettingItem(
              Icons.language,
              'Language',
              'English',
              () {
                Navigator.pushNamed(context, '/language_selection');
              },
            ),
            _buildSettingItem(
              Icons.attach_money,
              'Currency',
              'USD',
              () {
                Navigator.pushNamed(context, '/currency_selection');
              },
            ),
            const SizedBox(height: 25),

            // Data Management
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Data Management',
                style: TextStyle(
                  color: AppTheme.textWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

            _buildSettingItem(
              Icons.cloud_upload_outlined,
              'Export Data',
              'Download your expense data',
              () {
                Navigator.pushNamed(context, '/export_data');
              },
            ),
            _buildSettingItem(
              Icons.backup,
              'Backup',
              'Backup to cloud storage',
              () {},
            ),
            const SizedBox(height: 25),

            // About Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'About',
                style: TextStyle(
                  color: AppTheme.textWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

            _buildSettingItem(
              Icons.info_outline,
              'About BUDGETU',
              'Version 1.0.0',
              () {},
            ),
            _buildSettingItem(
              Icons.help_outline,
              'Help & Support',
              'Get help and contact support',
              () {},
            ),
            _buildSettingItem(
              Icons.privacy_tip_outlined,
              'Privacy Policy',
              'Read our privacy policy',
              () {},
            ),
            const SizedBox(height: 30),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppTheme.darkGreenCard,
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: AppTheme.textWhite),
                      ),
                      content: const Text(
                        'Are you sure you want to logout?',
                        style: TextStyle(color: AppTheme.textGray),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: AppTheme.textGray),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Handle logout
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: AppTheme.dangerRed),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.dangerRed),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: AppTheme.dangerRed,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 3),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGreenCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.neonGreen,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.textGray,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkGreenCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.neonGreen),
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.textWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppTheme.textGray,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppTheme.textGray,
        ),
        onTap: onTap,
      ),
    );
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home, 'Home', 0, currentIndex, () {
                Navigator.pushReplacementNamed(context, '/');
              }),
              _buildNavItem(Icons.account_balance, 'Budget', 1, currentIndex,
                  () {
                Navigator.pushNamed(context, '/budget');
              }),
              _buildNavItem(Icons.bar_chart, 'Track', 2, currentIndex, () {
                Navigator.pushNamed(context, '/statistics');
              }),
              _buildNavItem(Icons.person, 'Profile', 3, currentIndex, () {
                // Already on profile
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, int currentIndex,
      VoidCallback onTap) {
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
