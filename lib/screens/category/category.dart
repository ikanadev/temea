import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/store/category/category.dart';
import 'package:temea/utils/constants.dart';
import 'package:temea/widgets/app_drawer.dart';
import 'package:temea/widgets/heading.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    return Scaffold(
      appBar: const Heading(),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(categoryProvider.notifier)
              .saveCategory('Kevin', CategoryColor.green);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Text("hey"),
          Expanded(
            child: categories.when(
              data: (categories) => ListView(
                children: [
                  Text('${categories.length} items'),
                  for (final cat in categories) Text('$cat.name'),
                ],
              ),
              error: (err, stack) => Text('Error: $err'),
              loading: () => const Text('loading...'),
            ),
          ),
        ],
      ),
    );
  }
}
