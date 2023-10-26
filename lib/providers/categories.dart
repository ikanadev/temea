import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/providers/providers.dart';

final categoriesProv = Provider<List<Category>>((ref) {
  final repo = ref.watch(categoryRepoProv);
  final catsRes = repo.getCategories();
  return catsRes.getOrElse((err) => throw Exception(err));
});
