import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/store/category/category_model.dart';
import 'package:temea/store/isar/isar.dart';
import 'package:temea/store/uuid/uuid.dart';
import 'package:temea/utils/constants.dart';
import 'category_repository.dart';

class CategoryNotifier extends AsyncNotifier<List<Category>> {
  @override
  FutureOr<List<Category>> build() {
    final isar = ref.watch(isarProvider);
    return CategoryRepository.getCategories(isar.value!);
  }

  Future<void> addCategory(String name, CategoryColor color) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isar = ref.watch(isarProvider);
      final uuid = ref.watch(uuidProvider);
      final cat = Category(id: uuid.v4(), name: name, color: color);
      await CategoryRepository.saveCategory(isar.value!, cat);
      return CategoryRepository.getCategories(isar.value!);
    });
  }
}

final categoryProvider =
    AsyncNotifierProvider<CategoryNotifier, List<Category>>(
  () => CategoryNotifier(),
);
