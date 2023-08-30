import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/router.dart';
import 'package:temea/theme/theme.dart';

import 'objectbox.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await openStore();
  final sharedPrefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      storeProvider.overrideWithValue(store),
      sharedPrefsProvider.overrideWithValue(sharedPrefs),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'Temea',
      routerConfig: router,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: themeMode,
    );
  }
}
