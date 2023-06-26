import 'package:isar/isar.dart';
import 'package:temea/db/db.dart';
import 'package:temea/utils/utils.dart';

part 'activity_db.g.dart';

@Collection(accessor: "activity")
@Name("activity")
class ActivityDb {
  @Index(unique: true)
  late String id;

  Id get isarId => fastHash(id);

  @Index()
  late String name;

  @Index()
  late DateTime createdAt;

  DateTime? startedAt;

  DateTime? deletedAt;

  final category = IsarLink<CategoryDb>();
}
