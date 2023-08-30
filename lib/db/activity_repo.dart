import 'package:flutter_snowflake/flutter_snowflake.dart';
import 'package:temea/db/models/models.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/domain/repositories.dart';
import 'package:temea/objectbox.g.dart';

class ActivityDbRepository extends ActivityRepository {
  final Snowflake snowBuilder;
  final Store store;
  final Box<ActivityDb> actBox;

  ActivityDbRepository(this.store, this.snowBuilder)
      : actBox = store.box<ActivityDb>();

  @override
  List<Activity> getActivities() {
    final query = actBox.query(ActivityDb_.deletedAt.isNull()).build();
    final acts = query.find();
    query.close();
    return acts.map<Activity>((act) {
      return Activity(
        uuid: act.uuid,
        name: act.name,
        createdAt: DateTime.fromMillisecondsSinceEpoch(act.createdAt),
        iconName: act.iconName,
      );
    }).toList();
  }
}
