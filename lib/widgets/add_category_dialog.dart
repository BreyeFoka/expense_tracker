import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense_category.dart';
import '../providers/expense_provider.dart';
import '../theme/app_theme.dart';

class AddCategoryDialog extends StatefulWidget {
  final Function(ExpenseCategory) onAdd;

  const AddCategoryDialog({super.key, required this.onAdd});

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.darkGreenCard,
      title: const Text(
        'Add New Category',
        style: TextStyle(color: AppTheme.textWhite),
      ),
      content: TextField(
        controller: _controller,
        style: const TextStyle(color: AppTheme.textWhite),
        decoration: InputDecoration(
          labelText: 'Category Name',
          labelStyle: const TextStyle(color: AppTheme.textGray),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.textGray),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.neonGreen),
          ),
        ),
      ),
      actions: [
        TextButton(
          child:
              const Text('Cancel', style: TextStyle(color: AppTheme.textGray)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Add', style: TextStyle(color: AppTheme.neonGreen)),
          onPressed: () {
            var newCategory = ExpenseCategory(
                id: DateTime.now().toString(), name: _controller.text);
            widget.onAdd(newCategory);
            Provider.of<ExpenseProvider>(context, listen: false)
                .addCategory(newCategory);
            _controller.clear();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
