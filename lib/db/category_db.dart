import 'package:isar/isar.dart';
import 'package:temea/db/activity_db.dart';
import 'package:temea/utils/utils.dart';

part 'category_db.g.dart';

@Collection(accessor: 'category')
@Name('category')
class CategoryDb {
  CategoryDb({
    required this.id,
    required this.name,
    required this.color,
    required this.createdAt,
  });

  @Index(unique: true)
  final String id;

  Id get isarId => fastHash(id);

  String name;

  @enumerated
  CategoryColor color;

  DateTime createdAt;

  DateTime? deletedAt;

  @Backlink(to: 'category')
  final activities = IsarLinks<ActivityDb>();
}
