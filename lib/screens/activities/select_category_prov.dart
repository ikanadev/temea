import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/models/models.dart';
import 'package:temea/providers/category/category.dart';

class SelectedCategoryNotifier extends AsyncNotifier<Category> {
  @override
  Future<Category> build() async {
    final categories = await ref.watch(categoryProvider.future);
    if (categories.isEmpty) {
      throw Exception('At least a category was expected');
    }
    return categories[0];
  }

  void setCategory(Category cat) {
    state = AsyncValue.data(cat);
  }
}

final selectedCategoryProvider =
    AsyncNotifierProvider<SelectedCategoryNotifier, Category>(
  () => SelectedCategoryNotifier(),
);
