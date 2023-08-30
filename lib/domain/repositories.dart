import 'package:temea/domain/models/models.dart';

abstract class CategoryRepository {
  List<Category> getCategories();
  void saveCategory({required CategoryColor color, required String name});
  void updateCategory(Category category);
  void deleteCategory(int uuid);
}

abstract class ActivityRepository {
  List<Activity> getActivities();
}
