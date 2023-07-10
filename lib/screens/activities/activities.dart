import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/widgets/widgets.dart';

import 'activity_item.dart';

class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(activityProvider);
    return Scaffold(
      appBar: const Heading(title: 'Activities'),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (_) => const NewActivity());
        },
      ),
      body: activities.when(
        data: (acts) {
          if (acts.isEmpty) {
            return const NoDataMessage(
              message: 'Seems like you don\'t have any activity yet, '
                  'create one with the + button below.',
            );
          }
          return ListView.builder(
            itemCount: acts.length,
            itemBuilder: (context, index) => ActivityItem(act: acts[index]),
          );
        },
        error: (error, _) => Text(error.toString()),
        loading: () => const CircularProgress(text: 'Loading activities...'),
      ),
    );
  }
}
