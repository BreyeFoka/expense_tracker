import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/add_tag_dialog.dart';
import '../theme/app_theme.dart';

class TagManagementScreen extends StatelessWidget {
  const TagManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkGreen,
      appBar: AppBar(
        title: const Text("Manage Tags"),
        backgroundColor: AppTheme.darkGreen,
        foregroundColor: AppTheme.textWhite,
        elevation: 0,
      ),
      body: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.tags.length,
            itemBuilder: (context, index) {
              final tag = provider.tags[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppTheme.darkGreenCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(
                    tag.name,
                    style: const TextStyle(color: AppTheme.textWhite),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: AppTheme.dangerRed),
                    onPressed: () {
                      provider.deleteTag(tag.id);
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
            builder: (context) => AddTagDialog(
              onAdd: (newTag) {
                Provider.of<ExpenseProvider>(context, listen: false)
                    .addTag(newTag);
                Navigator.pop(context);
              },
            ),
          );
        },
        tooltip: 'Add New Tag',
        child: const Icon(Icons.add, color: AppTheme.darkGreen),
      ),
    );
  }
}
