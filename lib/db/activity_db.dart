import 'package:isar/isar.dart';
import 'package:temea/db/db.dart';
import 'package:temea/utils/utils.dart';

part 'activity_db.g.dart';

@Collection(accessor: "activity")
@Name("activity")
class ActivityDb {
  ActivityDb({
    required this.id,
    required this.name,
    required this.iconName,
    required this.createdAt,
  });

  @Index(unique: true)
  final String id;

  Id get isarId => fastHash(id);

  @Index()
  String name;
  String iconName;

  @Index()
  DateTime createdAt;

  DateTime? startedAt;

  DateTime? deletedAt;

  final category = IsarLink<CategoryDb>();
}
