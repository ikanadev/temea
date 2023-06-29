import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/screens/settings/theme_switcher.dart';
import 'package:temea/widgets/widgets.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const Heading(),
      drawer: const AppDrawer(),
      body: ListView(
        children: const [
          Text('Settings'),
          Divider(),
          ThemeSwitcher(),
        ],
      ),
    );
  }
}
