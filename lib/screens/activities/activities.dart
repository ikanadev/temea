import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/widgets/widgets.dart';

import 'activity_item.dart';

class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acts = ref.watch(activitiesProv);
    return Scaffold(
      appBar: const Heading(title: 'Activities'),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const NewActivityDialog(),
          );
        },
      ),
      body: acts.isEmpty
          ? const NoDataMessage(
              'Seems like you don\'t have any activity yet, '
              'create one with the + button below.',
            )
          : ListView.builder(
              itemCount: acts.length,
              itemBuilder: (context, index) => ActivityItem(act: acts[index]),
            ),
    );
  }
}
