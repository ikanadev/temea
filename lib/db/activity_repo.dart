import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snowflake/flutter_snowflake.dart';
import 'package:fpdart/fpdart.dart';
import 'package:temea/db/models/models.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/domain/repositories.dart';
import 'package:temea/domain/types.dart';
import 'package:temea/objectbox.g.dart';
import 'package:temea/providers/providers.dart';

class ActivityDbRepository extends ActivityRepository {
  final Snowflake snowBuilder;
  final Store store;
  final Box<ActivityDb> actBox;
  final Box<CategoryDb> catBox;
  final ProviderRef<ActivityRepository> ref;

  ActivityDbRepository(this.store, this.snowBuilder, this.ref)
      : actBox = store.box<ActivityDb>(),
        catBox = store.box<CategoryDb>();

  @override
  EitherActivities getActivities() {
    try {
      final query = actBox.query(ActivityDb_.deletedAt.isNull()).build();
      final acts = query.find();
      query.close();
      final resp = acts.map<Activity>((act) => act.toActivity()).toList();
      return right(resp);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  OptionErr saveActivity({
    required String name,
    required String iconName,
    Category? category,
  }) {
    try {
      final query = actBox
          .query(ActivityDb_.name.equals(name, caseSensitive: false))
          .build();
      final count = query.count();
      query.close();
      if (count > 0) {
        return some('Activity $name already exists.');
      }

      final act = ActivityDb(
        uuid: snowBuilder.getId(),
        name: name,
        iconName: iconName,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      if (category != null) {
        final q = catBox.query(CategoryDb_.uuid.equals(category.uuid)).build();
        final cat = q.findUnique();
        q.close();
        act.category.target = cat;
      }
      actBox.put(act);
      ref.invalidate(activitiesProv);
      return none();
    } catch (e) {
      return some(e.toString());
    }
  }
}
