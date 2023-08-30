import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/theme.dart';

class ThemeItem {
  ThemeMode key;
  String label;
  ThemeItem({required this.key, required this.label});
}

final List<ThemeItem> themeItems = [
  ThemeItem(key: ThemeMode.system, label: 'System'),
  ThemeItem(key: ThemeMode.dark, label: 'Dark'),
  ThemeItem(key: ThemeMode.light, label: 'Light'),
];

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return ListTile(
      title: const Text('Theme'),
      trailing: DropdownButton<ThemeMode>(
        value: themeMode,
        onChanged: (value) {
          if (value != null) {
            ref.read(themeProvider.notifier).setThemeMode(value);
          }
        },
        items: themeItems
            .map((themeItem) => DropdownMenuItem(
                  value: themeItem.key,
                  child: Text(themeItem.label),
                ))
            .toList(),
      ),
    );
  }
}
