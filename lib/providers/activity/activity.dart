import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:temea/db/activity_db.dart';
import 'package:temea/models/models.dart';
import 'package:temea/providers/isar/isar.dart';

class ActivityNotifier extends AsyncNotifier<List<Activity>>
    implements ActivityRepo {
  @override
  FutureOr<List<Activity>> build() {
    return getActivities();
  }

  @override
  Future<List<Activity>> getActivities() async {
    final isar = await ref.watch(isarProvider.future);
    final activities =
        await isar.activity.filter().deletedAtIsNotNull().findAll();
    return activities
        .map((act) => Activity(
              id: act.id,
              name: act.name,
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
}

final activityProvider =
    AsyncNotifierProvider<ActivityNotifier, List<Activity>>(
  () => ActivityNotifier(),
);
