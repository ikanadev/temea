import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snowflake/flutter_snowflake.dart';
import 'package:temea/db/models/models.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/domain/repositories.dart';
import 'package:temea/domain/types.dart';
import 'package:temea/objectbox.g.dart';
import 'package:temea/providers/providers.dart';

class CategoryDbRepository extends CategoryRepository {
  final Store store;
  final Snowflake snowBuilder;
  final Box<CategoryDb> catBox;
  final ProviderRef<CategoryRepository> ref;

  CategoryDbRepository(this.store, this.snowBuilder, this.ref)
      : catBox = store.box<CategoryDb>();

  @override
  EitherCategories getCategories() {
    try {
      final query = catBox.query(CategoryDb_.deletedAt.isNull()).build();
      final categories = query.find();
      query.close();
      final resp = categories.map<Category>((cat) {
        return Category(
          uuid: cat.uuid,
          name: cat.name,
          color: CategoryColor.values.firstWhere(
            (col) => col.name == cat.color,
            orElse: () => CategoryColor.blue,
          ),
          createdAt: DateTime.fromMillisecondsSinceEpoch(cat.createdAt),
        );
      }).toList();
      return right(resp);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  OptionErr saveCategory({required CategoryColor color, required String name}) {
    try {
      final query = catBox.query(CategoryDb_.name.equals(name)).build();
      final count = query.count();
      query.close();
      if (count > 0) return some("Category with that name already exists.");
      final cat = CategoryDb(
        uuid: snowBuilder.getId(),
        name: name,
        color: color.name,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      catBox.put(cat);
      ref.invalidate(categoriesProv);
      return none();
    } catch (e) {
      return some(e.toString());
    }
  }

  @override
  OptionErr updateCategory(Category category) {
    try {
      final query =
          catBox.query(CategoryDb_.uuid.equals(category.uuid)).build();
      final cat = query.findFirst();
      query.close();
      if (cat == null) return some("Category does not exists");
      cat.name = category.name;
      cat.color = category.color.name;
      cat.deletedAt = category.deletedAt?.microsecondsSinceEpoch;
      catBox.put(cat);
      ref.invalidate(categoriesProv);
      return none();
    } catch (e) {
      return some(e.toString());
    }
  }

  @override
  OptionErr deleteCategory(int uuid) {
    try {
      final query = catBox.query(CategoryDb_.uuid.equals(uuid)).build();
      final cat = query.findFirst();
      query.close();
      if (cat == null) return some("Category does not exists");
      cat.deletedAt = DateTime.now().millisecondsSinceEpoch;
      catBox.put(cat);
      ref.invalidate(categoriesProv);
      return none();
    } catch (e) {
      return some(e.toString());
    }
  }
}
