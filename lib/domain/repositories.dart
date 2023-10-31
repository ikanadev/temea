import 'package:temea/domain/models/models.dart';
import 'package:temea/domain/types.dart';

abstract class CategoryRepository {
  EitherCategories getCategories();
  OptionErr saveCategory({required CategoryColor color, required String name});
  OptionErr updateCategory(Category category);
  OptionErr deleteCategory(int uuid);
}

abstract class ActivityRepository {
  EitherActivities getActivities();
  OptionErr saveActivity({
    required String name,
    required String iconName,
    Category? category,
  });
}
