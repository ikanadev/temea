import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/providers/providers.dart';

final categoriesProv = Provider<List<Category>>((ref) {
  final repo = ref.watch(categoryRepoProv);
  return repo.getCategories();
});
