import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/domain/models/models.dart';
import 'package:temea/providers/providers.dart';
import 'package:temea/widgets/widgets.dart';

class DeleteCategoryDialog extends ConsumerWidget {
  const DeleteCategoryDialog({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: Text(
        'Are you sure you want to delete ${category.name}?. '
        'All the activities related will have an unassigned category.',
      ),
      actions: [
        CancelButton(
          label: 'Cancel',
          onClick: () => Navigator.of(context).pop(),
        ),
        DangerTextButton(
          onClick: () {
            ref.read(categoryRepoProv).deleteCategory(category.uuid);
            ref.invalidate(categoriesProv);
            Navigator.of(context).pop();
          },
          label: 'Delete',
        ),
      ],
    );
  }
}
