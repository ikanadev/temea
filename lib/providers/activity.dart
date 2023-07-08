import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:temea/db/db.dart';
import 'package:temea/models/models.dart';
import 'package:temea/providers/providers.dart';

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

  Future<void> saveActivity({
    required Activity act,
    required String? categoryId,
  }) async {
    try {
      final isar = await ref.watch(isarProvider.future);
      isar.writeTxn(() async {
        final actDb = ActivityDb(
          id: act.id,
          name: act.name,
          iconName: act.iconName,
          createdAt: act.createdAt,
        );
        await isar.activity.put(actDb);
        CategoryDb? catDb;
        if (categoryId != null) {
          catDb = await isar.category.getById(categoryId);
        }
        actDb.category.value = catDb;
        await actDb.category.save();
      });
      ref.invalidateSelf();
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> updateActivity({required Activity newAct}) async {
    try {
      final isar = await ref.watch(isarProvider.future);
      isar.writeTxn(() async {
        final actDb = ActivityDb(
          id: newAct.id,
          name: newAct.name,
          iconName: newAct.iconName,
          createdAt: newAct.createdAt,
        );
        await isar.activity.put(actDb);
        CategoryDb? catDb;
        if (newAct.category != null) {
          catDb = await isar.category.getById(newAct.category!.id);
        }
        actDb.category.value = catDb;
        actDb.category.save();
      });
      ref.invalidateSelf();
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}

final activityProvider =
    AsyncNotifierProvider<ActivityNotifier, List<Activity>>(
  () => ActivityNotifier(),
);
