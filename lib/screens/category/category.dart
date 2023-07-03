import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/category/category.dart';
import 'package:temea/theme/theme.dart';
import 'package:temea/utils/utils.dart';
import 'package:temea/widgets/widgets.dart';

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
                dense: true,
                title: Text(
                  cat.name,
                  style: TextStyle(
                      color: getCatColor(color: cat.color, context: context)),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      color: appTheme.neutralButton,
                      onPressed: () {
                        //
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      color: appTheme.dangerButton,
                      onPressed: () {
                        /*
                        ref
                            .read(categoryProvider.notifier)
                            .deleteCategory(cat.id);
                            */
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                onTap: () {
                  // ref.read(categoryProvider.notifier).deleteCategory(cat.id);
                },
              ),
          ],
        ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgress(text: 'Loading categories...'),
      ),
    );
  }
}
