import 'package:objectbox/objectbox.dart';
import 'package:temea/db/models/models.dart';
import 'package:temea/domain/models/models.dart';

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

  Category toCategory() {
    return Category(
      uuid: uuid,
      name: name,
      color: CategoryColor.values.firstWhere(
        (col) => col.name == color,
        orElse: () => CategoryColor.blue,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }
}
