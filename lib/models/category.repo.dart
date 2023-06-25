import 'package:temea/models/models.dart';
import 'package:temea/utils/constants.dart';

abstract class CategoryRepo {
  Future<List<Category>> getCategories();
  Future<void> saveCategory(String name, CategoryColor color);
  Future<void> deleteCategory(String uuid);
}
