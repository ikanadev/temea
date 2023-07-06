import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/widgets/widgets.dart';

import 'new_category.dart';
import 'animated_category_list.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
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
        data: (data) {
          if (data.isEmpty) {
            return const NoDataMessage(
              message: 'Seems like you don\'t have any categories yet.'
                  ' Create one with the + button below.',
            );
          }
          return AnimatedCategoryList(categories: data);
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgress(text: 'Loading categories...'),
      ),
    );
  }
}
