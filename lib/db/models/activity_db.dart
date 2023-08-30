import 'package:objectbox/objectbox.dart';
import 'package:temea/db/models/models.dart';

@Entity()
class ActivityDb {
  int id = 0;
  @Index()
  int uuid;
  String name;
  String iconName;
  int createdAt;
  int? startedAt;
  int? deletedAt;
  final category = ToOne<CategoryDb>();

  ActivityDb({
    required this.uuid,
    required this.name,
    required this.iconName,
    required this.createdAt,
  });
}
