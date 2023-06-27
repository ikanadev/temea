import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/models/models.dart';
import 'package:temea/providers/activity/activity.dart';
import 'package:temea/providers/category/category.dart';
import 'package:temea/screens/activities/select_category_prov.dart';
import 'package:temea/widgets/widgets.dart';

class ActivitiesScreen extends ConsumerStatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ActivitiesScreenState();
}

class _ActivitiesScreenState extends ConsumerState<ActivitiesScreen> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final activities = ref.watch(activityProvider);
    final selectedCat = ref.watch(selectedCategoryProvider);
    final categories = ref.watch(categoryProvider);
    return Scaffold(
      appBar: const Heading(),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (selectedCat.value != null) {
            print(selectedCat.value?.name);
            ref
                .read(activityProvider.notifier)
                .saveActivity(
                  nameController.text,
                  selectedCat.value!,
                )
                .then((value) {
              print('saved');
            }).catchError((err) {
              print('Error $err');
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Nombre'),
                  controller: nameController,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    categories.when(
                      data: (cats) => selectedCat.when(
                        data: (cat) => DropdownButton<Category>(
                          value: cat,
                          items: cats
                              .map(
                                (cat) => DropdownMenuItem<Category>(
                                  value: cat,
                                  child: Text(cat.name),
                                ),
                              )
                              .toList(),
                          onChanged: (cat) {
                            ref
                                .read(selectedCategoryProvider.notifier)
                                .setCategory(cat!);
                          },
                        ),
                        error: (_, __) => const Text('Error'),
                        loading: () => const CircularProgressIndicator(),
                      ),
                      error: (_, __) => const Text('Error'),
                      loading: () => const CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: activities.when(
              data: (acts) => ListView(
                children: acts.map((act) => Text(act.name)).toList(),
              ),
              error: (err, _) => Text(err.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
