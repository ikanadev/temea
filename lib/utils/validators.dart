import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/providers.dart';

String? categoryNameValidator(String? value, WidgetRef ref) {
  if (value == null) return 'Please enter a value';
  final cleanValue = value.trim().toLowerCase();
  if (cleanValue.isEmpty) return 'Please enter a value';
  final cats = ref.read(categoriesProv);
  if (cats.indexWhere((c) => c.name.toLowerCase() == cleanValue) >= 0) {
    return '${value.trim()} already exists';
  }
  return null;
}
