import 'package:flutter/material.dart';
import 'package:temea/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Heading(),
      drawer: AppDrawer(),
      body: Column(
        children: [Text('Home screen')],
      ),
    );
  }
}
