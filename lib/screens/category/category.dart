import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/category/category.dart';
import 'package:temea/screens/category/delete_category_dialog.dart';
import 'package:temea/screens/category/edit_category.dart';
import 'package:temea/theme/theme.dart';
import 'package:temea/utils/utils.dart';
import 'package:temea/widgets/widgets.dart';

import 'new_category.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    final appTheme = getAppTheme(context);
    return Scaffold(
      appBar: const Heading(title: 'My Categories'),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => const NewCategory());
        },
        child: const Icon(Icons.add),
      ),
      body: categories.when(
        data: (categories) => ListView(
          children: [
            if (categories.isEmpty)
              const NoDataMessage(
                message: 'Seems like you don\'t have any categories yet.'
                    ' Create one with the + button below.',
              ),
            for (final cat in categories)
              ListTile(
                contentPadding: const EdgeInsets.only(left: 16, right: 8),
                leading: Icon(
                  Icons.square_rounded,
                  size: 35,
                  color: getCatColor(color: cat.color, context: context),
                ),
                title: Text(
                  cat.name,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      color: appTheme.neutralButton,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => EditCategory(category: cat),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      color: appTheme.dangerButton,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => DeleteCategoryDialog(category: cat),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                onTap: () {
                  // TODO: go to category stats?
                },
              ),
            const SizedBox(height: 80),
          ],
        ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgress(text: 'Loading categories...'),
      ),
    );
  }
}
