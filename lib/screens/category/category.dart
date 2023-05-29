import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/store/category/category_provider.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);
    return categories.when(
      data: (categories) => ListView(
        children: [
          Text('${categories.length} items'),
          for (final cat in categories) Text('$cat.name'),
        ],
      ),
      error: (err, stack) => Text('Error: $err'),
      loading: () => const Text('loading...'),
    );
  }
}
