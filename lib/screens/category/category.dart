import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/category/category.dart';
import 'package:temea/utils/constants.dart';
import 'package:temea/widgets/app_drawer.dart';
import 'package:temea/widgets/heading.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Scaffold(
      appBar: const Heading(),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(categoryProvider.notifier)
              .saveCategory(nameController.text, CategoryColor.green)
              .then((_) => nameController.clear());
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Nombre'),
                  controller: nameController,
                ),
              ),
            ],
          ),
          Expanded(
            child: categories.when(
              data: (categories) => ListView(
                children: [
                  Text('${categories.length} items'),
                  for (final cat in categories)
                    Row(
                      children: [
                        Expanded(child: Text(cat.name)),
                        FilledButton(
                          onPressed: () {
                            ref
                                .read(categoryProvider.notifier)
                                .deleteCategory(cat.id);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
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
