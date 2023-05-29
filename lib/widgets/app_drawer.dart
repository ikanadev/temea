import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Drawer header')),
          ListTile(
            title: const Text('Time tracking'),
            onTap: () {
              context.go('/');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Activities'),
            onTap: () {
              context.go('/activities');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Stats'),
            onTap: () {
              context.go('/stats');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
