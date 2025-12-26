class AppConstants {
  // App Info
  static const String appName = 'BudgetU';
  static const String appVersion = 'V1.0.0';
  static const String appTagline = 'Student Budgeting Simplified';

  // Default Budget Values
  static const double defaultMonthlyBudget = 1250.00;
  static const double defaultFoodBudget = 400.00;
  static const double defaultRentBudget = 650.00;
  static const double defaultTransportBudget = 100.00;
  static const double defaultEntertainmentBudget = 100.00;

  // Currency Codes
  static const List<Map<String, String>> currencies = [
    {'code': 'USD', 'name': 'United States Dollar', 'symbol': '\$', 'flag': '🇺🇸'},
    {'code': 'EUR', 'name': 'Euro', 'symbol': '€', 'flag': '🇪🇺'},
    {'code': 'GBP', 'name': 'British Pound', 'symbol': '£', 'flag': '🇬🇧'},
    {'code': 'CAD', 'name': 'Canadian Dollar', 'symbol': 'C\$', 'flag': '🇨🇦'},
    {'code': 'JPY', 'name': 'Japanese Yen', 'symbol': '¥', 'flag': '🇯🇵'},
    {'code': 'AUD', 'name': 'Australian Dollar', 'symbol': 'A\$', 'flag': '🇦🇺'},
    {'code': 'GHS', 'name': 'Ghanaian Cedi', 'symbol': 'GHS', 'flag': '🇬🇭'},
  ];

  // Languages
  static const List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English (US)', 'subtitle': 'Default', 'flag': '🇺🇸'},
    {'code': 'es', 'name': 'Español', 'subtitle': 'Spanish', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'Français', 'subtitle': 'French', 'flag': '🇫🇷'},
    {'code': 'de', 'name': 'Deutsch', 'subtitle': 'German', 'flag': '🇩🇪'},
    {'code': 'zh', 'name': '中文', 'subtitle': 'Chinese (Simplified)', 'flag': '🇨🇳'},
    {'code': 'ja', 'name': '日本語', 'subtitle': 'Japanese', 'flag': '🇯🇵'},
  ];

  // Export Formats
  static const String csvFormat = 'CSV File';
  static const String pdfFormat = 'PDF Document';
}
