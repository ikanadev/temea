import 'package:flutter/material.dart';
import 'package:temea/widgets/app_drawer.dart';
import 'package:temea/widgets/heading.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Heading(),
      drawer: AppDrawer(),
      body: Column(
        children: [Text('activities screen')],
      ),
    );
  }
}
