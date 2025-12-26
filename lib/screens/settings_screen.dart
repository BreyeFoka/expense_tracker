import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currency = 'USD';
  bool _notifications = true;
  bool _biometricAuth = false;
  String _theme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          // General Settings
          _buildSectionHeader('General'),
          _buildCurrencyTile(),
          _buildThemeTile(),
          const Divider(),

          // Notifications
          _buildSectionHeader('Notifications'),
          _buildSwitchTile(
            'Enable Notifications',
            'Receive reminders and alerts',
            _notifications,
            (value) => setState(() => _notifications = value),
          ),
          const Divider(),

          // Security
          _buildSectionHeader('Security'),
          _buildSwitchTile(
            'Biometric Authentication',
            'Use fingerprint or face ID',
            _biometricAuth,
            (value) => setState(() => _biometricAuth = value),
          ),
          const Divider(),

          // Data Management
          _buildSectionHeader('Data Management'),
          _buildDataManagementTiles(),
          const Divider(),

          // About
          _buildSectionHeader('About'),
          _buildAboutTiles(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.indigoAccent,
        ),
      ),
    );
  }

  Widget _buildCurrencyTile() {
    return ListTile(
      leading: const Icon(Icons.attach_money),
      title: const Text('Currency'),
      subtitle: Text(_currency),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showCurrencyDialog(),
    );
  }

  Widget _buildThemeTile() {
    return ListTile(
      leading: const Icon(Icons.palette),
      title: const Text('Theme'),
      subtitle: Text(_theme),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showThemeDialog(),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      secondary: Icon(
        value ? Icons.check_circle : Icons.circle_outlined,
        color: value ? Colors.green : Colors.grey,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.indigoAccent,
    );
  }

  Widget _buildDataManagementTiles() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.upload_file),
          title: const Text('Export Data'),
          subtitle: const Text('Export expenses as CSV'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showExportDialog(),
        ),
        ListTile(
          leading: const Icon(Icons.backup),
          title: const Text('Backup'),
          subtitle: const Text('Backup data to cloud'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showBackupDialog(),
        ),
        Consumer<ExpenseProvider>(
          builder: (context, provider, child) => ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Clear All Data',
                style: TextStyle(color: Colors.red)),
            subtitle: const Text('Delete all expenses permanently'),
            onTap: () => _showClearDataDialog(provider),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutTiles() {
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Version'),
          subtitle: Text('1.0.0'),
        ),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Terms of Service'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showInfoDialog(
              'Terms of Service', 'Terms of service content here...'),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showInfoDialog(
              'Privacy Policy', 'Privacy policy content here...'),
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Help & Support'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showInfoDialog(
              'Help & Support', 'Contact us at support@expensetracker.com'),
        ),
      ],
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Currency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD'].map((currency) {
            return RadioListTile<String>(
              title: Text(currency),
              value: currency,
              groupValue: _currency,
              onChanged: (value) {
                setState(() => _currency = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Light', 'Dark', 'System'].map((theme) {
            return RadioListTile<String>(
              title: Text(theme),
              value: theme,
              groupValue: _theme,
              onChanged: (value) {
                setState(() => _theme = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('Export your expenses as a CSV file?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement export functionality
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data exported successfully')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup Data'),
        content: const Text('Backup your data to the cloud?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement backup functionality
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Backup completed')),
              );
            },
            child: const Text('Backup'),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(ExpenseProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all your expenses. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // Clear all expenses
              final expenseIds = provider.expenses.map((e) => e.id).toList();
              for (var id in expenseIds) {
                provider.deleteExpense(id);
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data cleared')),
              );
            },
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
