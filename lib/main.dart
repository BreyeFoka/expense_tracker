import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'providers/expense_provider.dart';
import 'screens/category_management_screen.dart';
import 'screens/tag_management_screen.dart';
import 'screens/new_home_screen.dart';
import 'screens/new_budget_screen.dart';
import 'screens/spending_insights_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/new_add_expense_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/email_sent_screen.dart';
import 'screens/currency_selection_screen.dart';
import 'screens/language_selection_screen.dart';
import 'screens/notifications_settings_screen.dart';
import 'screens/export_data_screen.dart';
import 'screens/privacy_security_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/budget_personalization_screen.dart';
import 'screens/review_transaction_screen.dart';
import 'screens/import_momo_screen.dart';
import 'screens/scan_receipt_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;

  const MyApp({super.key, required this.localStorage});

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// ****  13e25c58-2054-4492-8164-4a247493296d  ******
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider(localStorage)),
      ],
      child: MaterialApp(
        title: 'BUDGETU',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppTheme.darkGreen,
          primaryColor: AppTheme.neonGreen,
          fontFamily: 'Roboto',
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/forgot_password': (context) => ForgotPasswordScreen(),
          '/email_sent': (context) => const EmailSentScreen(),
          '/': (context) => const NewHomeScreen(),
          '/manage_categories': (context) => const CategoryManagementScreen(),
          '/manage_tags': (context) => const TagManagementScreen(),
          '/statistics': (context) => const SpendingInsightsScreen(),
          '/budget': (context) => const NewBudgetScreen(),
          '/add_expense': (context) => const NewAddExpenseScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/wallet': (context) => const WalletScreen(),
          '/analytics': (context) => const AnalyticsScreen(),
          '/currency_selection': (context) => const CurrencySelectionScreen(),
          '/language_selection': (context) => const LanguageSelectionScreen(),
          '/notifications_settings': (context) => const NotificationsSettingsScreen(),
          '/export_data': (context) => const ExportDataScreen(),
          '/privacy_security': (context) => const PrivacySecurityScreen(),
          '/edit_profile': (context) => const EditProfileScreen(),
          '/budget_personalization': (context) => const BudgetPersonalizationScreen(),
          '/review_transaction': (context) => const ReviewTransactionScreen(),
          '/import_momo': (context) => const ImportMomoScreen(),
          '/scan_receipt': (context) => const ScanReceiptScreen(),
        },
        // Removed 'home:' since 'initialRoute' is used to define the home route
      ),
    );
  }
}
