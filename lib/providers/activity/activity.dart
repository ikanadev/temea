import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:temea/db/activity_db.dart';
import 'package:temea/db/category_db.dart';
import 'package:temea/models/models.dart';
import 'package:temea/providers/isar/isar.dart';
import 'package:temea/providers/uuid/uuid.dart';

class ActivityNotifier extends AsyncNotifier<List<Activity>> {
  @override
  FutureOr<List<Activity>> build() {
    return _getActivities();
  }

  Future<List<Activity>> _getActivities() async {
    final isar = await ref.watch(isarProvider.future);
    final activities = await isar.activity.filter().deletedAtIsNull().findAll();
    return activities
        .map((act) => Activity(
              id: act.id,
              name: act.name,
              iconName: '',
              createdAt: act.createdAt,
              startedAt: act.startedAt,
              category: act.category.value != null
                  ? Category(
                      id: act.category.value!.id,
                      name: act.category.value!.name,
                      color: act.category.value!.color,
                      createdAt: act.category.value!.createdAt,
                    )
                  : null,
            ))
        .toList();
  }

  Future<void> saveActivity(String name, Category cat) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarProvider.future);
      final uuid = ref.watch(uuidProvider);
      final act = ActivityDb()
        ..id = uuid.v4()
        ..name = name
        ..createdAt = DateTime.now();
      final catDb = await isar.category.getById(cat.id);
      if (catDb == null) {
        throw Exception('category with id: ${cat.id} does not exists');
      }
      catDb.activities.add(act);
      await isar.writeTxn(() async {
        await isar.activity.put(act);
        await catDb.activities.save();
      });
      return _getActivities();
    });
  }
}

final activityProvider =
    AsyncNotifierProvider<ActivityNotifier, List<Activity>>(
  () => ActivityNotifier(),
);
