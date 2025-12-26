import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool pushNotifications = true;
  bool emailAlerts = true;
  bool budgetExceeded = true;
  bool nearLimit = true;
  bool weeklySummary = false;
  bool newFeatures = true;
  bool securityAlerts = true;

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
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'General',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildSettingTile(
            'Push Notifications',
            'Receive notifications on your device',
            pushNotifications,
            (value) => setState(() => pushNotifications = value),
          ),
          _buildSettingTile(
            'Email Alerts',
            'Get updates via email',
            emailAlerts,
            (value) => setState(() => emailAlerts = value),
          ),

          const SizedBox(height: 24),
          const Text(
            'Budget Alerts',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildSettingTile(
            'Budget Exceeded',
            'Alert when you exceed your budget',
            budgetExceeded,
            (value) => setState(() => budgetExceeded = value),
          ),
          _buildSettingTile(
            'Near Limit',
            'Notify when approaching budget limit',
            nearLimit,
            (value) => setState(() => nearLimit = value),
          ),
          _buildSettingTile(
            'Weekly Summary',
            'Get weekly spending summary',
            weeklySummary,
            (value) => setState(() => weeklySummary = value),
          ),

          const SizedBox(height: 24),
          const Text(
            'Other',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildSettingTile(
            'New Features',
            'Updates about new features',
            newFeatures,
            (value) => setState(() => newFeatures = value),
          ),
          _buildSettingTile(
            'Security Alerts',
            'Important security notifications',
            securityAlerts,
            (value) => setState(() => securityAlerts = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGreenCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.neonGreen,
            activeTrackColor: AppTheme.neonGreen.withOpacity(0.5),
            inactiveThumbColor: Colors.grey[600],
            inactiveTrackColor: Colors.grey[800],
          ),
        ],
      ),
    );
  }
}
