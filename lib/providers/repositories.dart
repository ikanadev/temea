import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/db/db.dart';
import 'package:temea/domain/repositories.dart';
import 'package:temea/providers/providers.dart';

final activityRepoProv = Provider<ActivityRepository>((ref) {
  return ActivityDbRepository(
    ref.watch(storeProvider),
    ref.watch(snowProv),
    ref,
  );
});

final categoryRepoProv = Provider<CategoryRepository>((ref) {
  return CategoryDbRepository(
    ref.watch(storeProvider),
    ref.watch(snowProv),
    ref,
  );
});
