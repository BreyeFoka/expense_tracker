// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/add_category_dialog.dart';
import '../theme/app_theme.dart';

// Example for CategoryManagementScreen
class CategoryManagementScreen extends StatelessWidget {
  const CategoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkGreen,
      appBar: AppBar(
        title: Text("Manage Categories"),
        backgroundColor: AppTheme.darkGreen,
        foregroundColor: AppTheme.textWhite,
        elevation: 0,
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              final category = provider.categories[index];
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppTheme.darkGreenCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(
                    category.name,
                    style: TextStyle(color: AppTheme.textWhite),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: AppTheme.dangerRed),
                    onPressed: () {
                      provider.deleteCategory(category.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.neonGreen,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddCategoryDialog(
              onAdd: (newCategory) {
                Provider.of<ExpenseProvider>(context, listen: false)
                    .addCategory(newCategory);
                Navigator.pop(context);
              },
            ),
          );
        },
        tooltip: 'Add New Category',
        child: Icon(Icons.add, color: AppTheme.darkGreen),
      ),
    );
  }
}
