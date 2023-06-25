import 'package:isar/isar.dart';
import 'package:temea/utils/utils.dart';

part 'category_db.g.dart';

@Collection(accessor: "category")
@Name("category")
class CategoryDb {
  @Index(unique: true)
  late String id;

  Id get isarId => fastHash(id);

  late String name;

  @enumerated
  late CategoryColor color;

  late DateTime createdAt;

  DateTime? deletedAt;
}
