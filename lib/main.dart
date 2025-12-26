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
          '/': (context) => const NewHomeScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/manage_categories': (context) => const CategoryManagementScreen(),
          '/manage_tags': (context) => const TagManagementScreen(),
          '/statistics': (context) => const SpendingInsightsScreen(),
          '/budget': (context) => const NewBudgetScreen(),
          '/add_expense': (context) => const NewAddExpenseScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/wallet': (context) => const WalletScreen(),
          '/analytics': (context) => const AnalyticsScreen(),
        },
        // Removed 'home:' since 'initialRoute' is used to define the home route
      ),
    );
  }
}
