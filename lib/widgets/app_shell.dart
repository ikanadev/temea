import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:temea/widgets/app_drawer.dart';
import 'package:temea/widgets/heading.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      appBar: const Heading(),
      drawer: const AppDrawer(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Activities',
          ),
          NavigationDestination(
            icon: Icon(Icons.timelapse),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.charging_station_rounded),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
