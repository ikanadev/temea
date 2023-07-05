import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:temea/db/db.dart';
import 'package:temea/models/models.dart';
import 'package:temea/providers/providers.dart';

class ActivityNotifier extends AsyncNotifier<List<Activity>> {
  @override
  FutureOr<List<Activity>> build() {
    ref.watch(categoryProvider);
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

  Future<void> saveActivity({
    required Activity act,
    required String categoryId,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isar = await ref.watch(isarProvider.future);
      await isar.writeTxn(() async {
        final catDb = await isar.category.getById(categoryId);
        if (catDb == null) {
          throw Exception('category with id: $categoryId does not exists');
        }
        final actDb = ActivityDb(
          id: act.id,
          name: act.name,
          iconName: act.iconName,
          createdAt: DateTime.now(),
        );
        await isar.activity.put(actDb);
        catDb.activities.add(actDb);
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
