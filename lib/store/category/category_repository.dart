import 'package:isar/isar.dart';
import 'package:temea/store/category/category_db.dart';

import 'category_model.dart';

class CategoryRepository {
  static Future<List<Category>> getCategories(Isar isar) async {
    final categories = await isar.categoryDbs.where().findAll();
    return categories
        .map((cat) => Category(id: cat.id, name: cat.name, color: cat.color))
        .toList();
  }

  static Future<void> saveCategory(Isar isar, Category category) async {
    final cat = CategoryDb()
      ..id = category.id
      ..name = category.name
      ..color = category.color;

    await isar.writeTxn(() async {
      await isar.categoryDbs.put(cat);
    });
  }
}
