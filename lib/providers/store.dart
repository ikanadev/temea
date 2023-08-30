import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/objectbox.g.dart';

late Store dummyStore; // This will be overrited in main.dart
final storeProvider = Provider<Store>((ref) => dummyStore);
