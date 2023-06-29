import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/theme.dart';
import 'package:temea/router.dart';
import 'package:temea/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

const errorScreen = MaterialApp(
  home: Text('Error reading theme from shared preferences'),
);

const loadingScreen = MaterialApp(
  home: Text('Loading...'),
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProv = ref.watch(themeProvider);
    return themeProv.when(
      data: (theme) => MaterialApp.router(
        title: 'Temea',
        routerConfig: router,
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: theme,
      ),
      error: (_, __) => errorScreen,
      loading: () => loadingScreen,
    );
  }
}
