import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:temea/store/category/category_db.dart';

final isarProvider = FutureProvider((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([CategoryDbSchema], directory: dir.path);
  return isar;
});
