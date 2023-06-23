import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:temea/db/db.dart';
import 'package:temea/store/isar/isar.dart';
import 'package:temea/store/uuid/uuid.dart';
import 'package:temea/utils/constants.dart';
import 'package:temea/models/models.dart';

class CategoryNotifier extends AsyncNotifier<List<Category>>
    implements CategoryRepo {
  @override
  Future<List<Category>> build() {
    return getCategories();
  }

  @override
  Future<List<Category>> getCategories() async {
    final isar = ref.watch(isarProvider).value;
    final categories = await isar?.categoryDbs.where().findAll() ?? [];
    return categories
        .map((cat) => Category(id: cat.id, name: cat.name, color: cat.color))
        .toList();
  }

  @override
  Future<void> saveCategory(String name, CategoryColor color) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isar = ref.watch(isarProvider).value;
      final uuid = ref.watch(uuidProvider);
      final cat = Category(id: uuid.v4(), name: name, color: color);
      await isar?.writeTxn(() async {
        await isar.categoryDbs.put(CategoryDb()
          ..id = cat.id
          ..name = cat.name
          ..color = cat.color);
      });
      return getCategories();
    });
  }
}

final categoryProvider =
    AsyncNotifierProvider<CategoryNotifier, List<Category>>(
  () => CategoryNotifier(),
);
