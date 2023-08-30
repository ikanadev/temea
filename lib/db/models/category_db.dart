import 'package:objectbox/objectbox.dart';
import 'package:temea/db/models/models.dart';

@Entity()
class CategoryDb {
  int id = 0;
  @Index()
  int uuid;
  @Index()
  String name;
  String color;
  int createdAt;
  int? deletedAt;
  @Backlink('category')
  final activities = ToMany<ActivityDb>();

  CategoryDb({
    required this.uuid,
    required this.name,
    required this.color,
    required this.createdAt,
  });
}
