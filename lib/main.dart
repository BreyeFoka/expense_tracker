import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'providers/expense_provider.dart';
import 'screens/category_management_screen.dart';
import 'screens/home_screen.dart';
import 'screens/tag_management_screen.dart';
import 'screens/new_home_screen.dart';
import 'screens/new_budget_screen.dart';
import 'screens/spending_insights_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/new_add_expense_screen.dart';
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
        initialRoute: '/',
        routes: {
          '/': (context) =>
              const NewHomeScreen(), // Main entry point, HomeScreen
          '/onboarding': (context) => const OnboardingScreen(),
          '/manage_categories': (context) =>
              const CategoryManagementScreen(), // Route for managing categories
          '/manage_tags': (context) =>
              const TagManagementScreen(), // Route for managing tags
          '/statistics': (context) =>
              const SpendingInsightsScreen(), // Route for statistics
          '/budget': (context) => const NewBudgetScreen(), // Route for budget
          '/settings': (context) =>
              const NewHomeScreen(), // Placeholder - update later
          '/add_expense': (context) =>
              const NewAddExpenseScreen(), // Route for adding expense
        },
        // Removed 'home:' since 'initialRoute' is used to define the home route
      ),
    );
  }
}
