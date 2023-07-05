import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:temea/db/db.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/utils/utils.dart';
import 'package:temea/models/models.dart';

class CategoryNotifier extends AsyncNotifier<List<Category>> {
  @override
  Future<List<Category>> build() {
    return _getCategories();
  }

  Future<List<Category>> _getCategories() async {
    final isar = await ref.watch(isarProvider.future);
    final categories = await isar.category
        .filter()
        .deletedAtIsNull()
        .sortByCreatedAt()
        .findAll();
    return categories
        .map((cat) => Category(
              id: cat.id,
              name: cat.name,
              color: cat.color,
              createdAt: cat.createdAt,
            ))
        .toList();
  }

  Future<void> saveCategory({
    required String name,
    required CategoryColor color,
  }) async {
    try {
      final isar = await ref.watch(isarProvider.future);
      final uuid = ref.watch(uuidProvider);
      await isar.writeTxn(() async {
        await isar.category.put(CategoryDb(
          id: uuid.v4(),
          name: name,
          color: color,
          createdAt: DateTime.now(),
        ));
      });
      ref.invalidateSelf();
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> updateCategory({required Category cat}) async {
    try {
      final isar = await ref.watch(isarProvider.future);
      await isar.writeTxn(() async {
        await isar.category.putById(CategoryDb(
          id: cat.id,
          name: cat.name,
          color: cat.color,
          createdAt: cat.createdAt,
        ));
      });
      ref.invalidate(activityProvider);
      ref.invalidateSelf();
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  // TODO: handle side effects (delete all activities?, show popup?)
  Future<void> deleteCategory(String uuid) async {
    try {
      final isar = await ref.watch(isarProvider.future);
      await isar.writeTxn(() async {
        await isar.category.deleteById(uuid);
      });
      ref.invalidate(activityProvider);
      ref.invalidateSelf();
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}

final categoryProvider =
    AsyncNotifierProvider<CategoryNotifier, List<Category>>(
  () => CategoryNotifier(),
);
