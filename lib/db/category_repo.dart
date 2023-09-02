import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snowflake/flutter_snowflake.dart';
import 'package:temea/db/models/models.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/domain/repositories.dart';
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
  List<Category> getCategories() {
    final query = catBox.query(CategoryDb_.deletedAt.isNull()).build();
    final categories = query.find();
    query.close();
    return categories.map<Category>((cat) {
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
  }

  @override
  void saveCategory({required CategoryColor color, required String name}) {
    final cat = CategoryDb(
      uuid: snowBuilder.getId(),
      name: name,
      color: color.name,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    catBox.put(cat);
    ref.invalidate(categoriesProv);
  }

  @override
  void updateCategory(Category category) {
    final query = catBox.query(CategoryDb_.uuid.equals(category.uuid)).build();
    final cat = query.findFirst();
    query.close();
    if (cat == null) return;
    cat.name = category.name;
    cat.color = category.color.name;
    cat.deletedAt = category.deletedAt?.microsecondsSinceEpoch;
    catBox.put(cat);
    ref.invalidate(categoriesProv);
  }

  @override
  void deleteCategory(int uuid) {
    final query = catBox.query(CategoryDb_.uuid.equals(uuid)).build();
    final cat = query.findFirst();
    query.close();
    if (cat == null) return;
    cat.deletedAt = DateTime.now().millisecondsSinceEpoch;
    catBox.put(cat);
    ref.invalidate(categoriesProv);
  }
}
