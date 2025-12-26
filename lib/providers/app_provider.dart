import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import '../models/user.dart';
import '../models/expense.dart';
import '../models/expense_category.dart';
import '../models/tag.dart';
import '../models/budget.dart';
import '../models/app_settings.dart';

class AppProvider with ChangeNotifier {
  final LocalStorage storage;

  // User data
  User? _currentUser;
  bool _isLoggedIn = false;

  // Expenses
  List<Expense> _expenses = [];

  // Categories
  List<ExpenseCategory> _categories = [
    ExpenseCategory(id: '1', name: 'Food', isDefault: true),
    ExpenseCategory(id: '2', name: 'Transport', isDefault: true),
    ExpenseCategory(id: '3', name: 'Entertainment', isDefault: true),
    ExpenseCategory(id: '4', name: 'Books', isDefault: true),
    ExpenseCategory(id: '5', name: 'Shopping', isDefault: true),
    ExpenseCategory(id: '6', name: 'Bills', isDefault: true),
    ExpenseCategory(id: '7', name: 'Other', isDefault: true),
  ];

  // Tags
  List<Tag> _tags = [
    Tag(id: '1', name: 'Breakfast'),
    Tag(id: '2', name: 'Lunch'),
    Tag(id: '3', name: 'Dinner'),
    Tag(id: '4', name: 'Coffee'),
    Tag(id: '5', name: 'Snacks'),
  ];

  // Budgets
  List<Budget> _budgets = [];

  // Settings
  AppSettings _settings = AppSettings();

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  List<Expense> get expenses => _expenses;
  List<ExpenseCategory> get categories => _categories;
  List<Tag> get tags => _tags;
  List<Budget> get budgets => _budgets;
  AppSettings get settings => _settings;

  AppProvider(this.storage) {
    _loadData();
  }

  // Load all data from storage
  Future<void> _loadData() async {
    // Load user
    var userData = storage.getItem('user');
    if (userData != null) {
      _currentUser = User.fromJson(jsonDecode(userData));
      _isLoggedIn = true;
    }

    // Load expenses
    var expensesData = storage.getItem('expenses');
    if (expensesData != null) {
      _expenses = (jsonDecode(expensesData) as List)
          .map((item) => Expense.fromJson(item))
          .toList();
    }

    // Load categories
    var categoriesData = storage.getItem('categories');
    if (categoriesData != null) {
      _categories = (jsonDecode(categoriesData) as List)
          .map((item) => ExpenseCategory(
                id: item['id'],
                name: item['name'],
                isDefault: item['isDefault'] ?? false,
              ))
          .toList();
    }

    // Load tags
    var tagsData = storage.getItem('tags');
    if (tagsData != null) {
      _tags = (jsonDecode(tagsData) as List)
          .map((item) => Tag(id: item['id'], name: item['name']))
          .toList();
    }

    // Load budgets
    var budgetsData = storage.getItem('budgets');
    if (budgetsData != null) {
      _budgets = (jsonDecode(budgetsData) as List)
          .map((item) => Budget.fromJson(item))
          .toList();
    }

    // Load settings
    var settingsData = storage.getItem('settings');
    if (settingsData != null) {
      _settings = AppSettings.fromJson(jsonDecode(settingsData));
    }

    notifyListeners();
  }

  // Save data to storage
  void _saveUser() {
    if (_currentUser != null) {
      storage.setItem('user', jsonEncode(_currentUser!.toJson()));
    }
  }

  void _saveExpenses() {
    storage.setItem(
      'expenses',
      jsonEncode(_expenses.map((e) => e.toJson()).toList()),
    );
  }

  void _saveCategories() {
    storage.setItem(
      'categories',
      jsonEncode(_categories.map((c) => {
        'id': c.id,
        'name': c.name,
        'isDefault': c.isDefault,
      }).toList()),
    );
  }

  void _saveTags() {
    storage.setItem(
      'tags',
      jsonEncode(_tags.map((t) => {'id': t.id, 'name': t.name}).toList()),
    );
  }

  void _saveBudgets() {
    storage.setItem(
      'budgets',
      jsonEncode(_budgets.map((b) => b.toJson()).toList()),
    );
  }

  void _saveSettings() {
    storage.setItem('settings', jsonEncode(_settings.toJson()));
  }

  // === AUTH METHODS ===
  
  Future<bool> login(String email, String password) async {
    // Simulate login - In production, verify against stored credentials
    var userData = storage.getItem('user');
    if (userData != null) {
      _currentUser = User.fromJson(jsonDecode(userData));
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signup(String name, String email, String password) async {
    // Create new user
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
    );
    _isLoggedIn = true;
    _saveUser();
    
    // Initialize default budgets
    _initializeDefaultBudgets();
    
    notifyListeners();
    return true;
  }

  void _initializeDefaultBudgets() {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, 1);
    final endDate = DateTime(now.year, now.month + 1, 0);

    _budgets = [
      Budget(
        id: '1',
        categoryId: '1', // Food
        amount: 300.0,
        startDate: startDate,
        endDate: endDate,
      ),
      Budget(
        id: '2',
        categoryId: '2', // Transport
        amount: 100.0,
        startDate: startDate,
        endDate: endDate,
      ),
      Budget(
        id: '3',
        categoryId: '3', // Entertainment
        amount: 150.0,
        startDate: startDate,
        endDate: endDate,
      ),
      Budget(
        id: '4',
        categoryId: '4', // Books
        amount: 50.0,
        startDate: startDate,
        endDate: endDate,
      ),
    ];
    _saveBudgets();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateUser(User user) {
    _currentUser = user;
    _saveUser();
    notifyListeners();
  }

  // === EXPENSE METHODS ===

  void addExpense(Expense expense) {
    _expenses.add(expense);
    _saveExpenses();
    notifyListeners();
  }

  void updateExpense(Expense expense) {
    int index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
      _saveExpenses();
      notifyListeners();
    }
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    _saveExpenses();
    notifyListeners();
  }

  // Get expenses for a specific date range
  List<Expense> getExpensesByDateRange(DateTime start, DateTime end) {
    return _expenses.where((e) {
      return e.date.isAfter(start.subtract(const Duration(days: 1))) &&
          e.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  // Get expenses by category
  List<Expense> getExpensesByCategory(String categoryId) {
    return _expenses.where((e) => e.categoryId == categoryId).toList();
  }

  // Get total spent
  double getTotalSpent({DateTime? start, DateTime? end}) {
    var expenseList = _expenses;
    if (start != null && end != null) {
      expenseList = getExpensesByDateRange(start, end);
    }
    return expenseList.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  // Get total spent by category
  double getSpentByCategory(String categoryId, {DateTime? start, DateTime? end}) {
    var expenseList = getExpensesByCategory(categoryId);
    if (start != null && end != null) {
      expenseList = expenseList.where((e) {
        return e.date.isAfter(start.subtract(const Duration(days: 1))) &&
            e.date.isBefore(end.add(const Duration(days: 1)));
      }).toList();
    }
    return expenseList.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  // === CATEGORY METHODS ===

  void addCategory(ExpenseCategory category) {
    if (!_categories.any((c) => c.name.toLowerCase() == category.name.toLowerCase())) {
      _categories.add(category);
      _saveCategories();
      notifyListeners();
    }
  }

  void deleteCategory(String id) {
    // Don't delete if it's a default category
    final category = _categories.firstWhere((c) => c.id == id);
    if (!category.isDefault) {
      _categories.removeWhere((c) => c.id == id);
      _saveCategories();
      notifyListeners();
    }
  }

  ExpenseCategory? getCategoryById(String id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  // === TAG METHODS ===

  void addTag(Tag tag) {
    if (!_tags.any((t) => t.name.toLowerCase() == tag.name.toLowerCase())) {
      _tags.add(tag);
      _saveTags();
      notifyListeners();
    }
  }

  void deleteTag(String id) {
    _tags.removeWhere((t) => t.id == id);
    _saveTags();
    notifyListeners();
  }

  // === BUDGET METHODS ===

  void addBudget(Budget budget) {
    _budgets.add(budget);
    _saveBudgets();
    notifyListeners();
  }

  void updateBudget(Budget budget) {
    int index = _budgets.indexWhere((b) => b.id == budget.id);
    if (index != -1) {
      _budgets[index] = budget;
      _saveBudgets();
      notifyListeners();
    }
  }

  void deleteBudget(String id) {
    _budgets.removeWhere((b) => b.id == id);
    _saveBudgets();
    notifyListeners();
  }

  Budget? getBudgetByCategory(String categoryId) {
    try {
      return _budgets.firstWhere((b) => b.categoryId == categoryId);
    } catch (e) {
      return null;
    }
  }

  double getBudgetProgress(String categoryId) {
    final budget = getBudgetByCategory(categoryId);
    if (budget == null) return 0.0;

    final spent = getSpentByCategory(
      categoryId,
      start: budget.startDate,
      end: budget.endDate,
    );

    return budget.amount > 0 ? (spent / budget.amount) * 100 : 0.0;
  }

  double getRemainingBudget(String categoryId) {
    final budget = getBudgetByCategory(categoryId);
    if (budget == null) return 0.0;

    final spent = getSpentByCategory(
      categoryId,
      start: budget.startDate,
      end: budget.endDate,
    );

    return budget.amount - spent;
  }

  // Get total budget
  double getTotalBudget() {
    return _budgets.fold(0.0, (sum, budget) => sum + budget.amount);
  }

  // === SETTINGS METHODS ===

  void updateSettings(AppSettings settings) {
    _settings = settings;
    _saveSettings();
    notifyListeners();
  }

  void updateCurrency(String currency) {
    _settings = _settings.copyWith(currency: currency);
    _saveSettings();
    notifyListeners();
  }

  void updateLanguage(String language) {
    _settings = _settings.copyWith(language: language);
    _saveSettings();
    notifyListeners();
  }

  void toggleNotification(String key, bool value) {
    switch (key) {
      case 'pushNotifications':
        _settings = _settings.copyWith(pushNotifications: value);
        break;
      case 'emailAlerts':
        _settings = _settings.copyWith(emailAlerts: value);
        break;
      case 'budgetExceeded':
        _settings = _settings.copyWith(budgetExceeded: value);
        break;
      case 'nearLimit':
        _settings = _settings.copyWith(nearLimit: value);
        break;
      case 'weeklySummary':
        _settings = _settings.copyWith(weeklySummary: value);
        break;
      case 'newFeatures':
        _settings = _settings.copyWith(newFeatures: value);
        break;
      case 'securityAlerts':
        _settings = _settings.copyWith(securityAlerts: value);
        break;
      case 'biometricLogin':
        _settings = _settings.copyWith(biometricLogin: value);
        break;
      case 'twoStepVerification':
        _settings = _settings.copyWith(twoStepVerification: value);
        break;
      case 'dataSharing':
        _settings = _settings.copyWith(dataSharing: value);
        break;
    }
    _saveSettings();
    notifyListeners();
  }

  // === STATISTICS METHODS ===

  Map<String, double> getCategorySpending({DateTime? start, DateTime? end}) {
    Map<String, double> spending = {};
    
    for (var category in _categories) {
      final amount = getSpentByCategory(category.id, start: start, end: end);
      if (amount > 0) {
        spending[category.name] = amount;
      }
    }
    
    return spending;
  }

  // Get daily spending for the week
  Map<String, double> getDailySpending() {
    Map<String, double> dailySpending = {};
    final now = DateTime.now();
    
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayKey = _getDayName(date.weekday);
      
      final dayExpenses = _expenses.where((e) =>
        e.date.year == date.year &&
        e.date.month == date.month &&
        e.date.day == date.day
      ).toList();
      
      dailySpending[dayKey] = dayExpenses.fold(0.0, (sum, e) => sum + e.amount);
    }
    
    return dailySpending;
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  // Clear all data (for testing or account deletion)
  Future<void> clearAllData() async {
    _currentUser = null;
    _isLoggedIn = false;
    _expenses.clear();
    _budgets.clear();
    _settings = AppSettings();
    
    storage.clear();
    notifyListeners();
  }
}
