import 'package:isar/isar.dart';
import 'package:temea/utils/fast_hash.dart';
import 'package:temea/utils/constants.dart';

part 'category_db.g.dart';

@collection
class CategoryDb {
  late String id;
  Id get isarId => fastHash(id);
  late String name;

  @enumerated
  late CategoryColor color;
}
