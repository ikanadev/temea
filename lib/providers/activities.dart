import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/providers/providers.dart';

final activitiesProv = Provider<List<Activity>>((ref) {
  final repo = ref.watch(activityRepoProv);
  return repo.getActivities();
});
