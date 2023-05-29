import 'package:flutter/material.dart';

import 'package:temea/widgets/app_drawer.dart';
import 'package:temea/widgets/heading.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Heading(),
      drawer: const AppDrawer(),
      body: child,
    );
  }
}
