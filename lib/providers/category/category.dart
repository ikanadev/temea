import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:temea/db/db.dart';
import 'package:temea/providers/isar/isar.dart';
import 'package:temea/providers/uuid/uuid.dart';
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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
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
      return _getCategories();
    });
  }

  Future<void> updateCategory({required Category cat}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarProvider.future);
      await isar.writeTxn(() async {
        await isar.category.putById(CategoryDb(
          id: cat.id,
          name: cat.name,
          color: cat.color,
          createdAt: cat.createdAt,
        ));
      });
      return _getCategories();
    });
  }

  // TODO: handle side effects (delete all activities?, show popup?)
  Future<void> deleteCategory(String uuid) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarProvider.future);
      await isar.writeTxn(() async {
        await isar.category.filter().idEqualTo(uuid).deleteAll();
      });
      return _getCategories();
    });
  }
}

final categoryProvider =
    AsyncNotifierProvider<CategoryNotifier, List<Category>>(
  () => CategoryNotifier(),
);
