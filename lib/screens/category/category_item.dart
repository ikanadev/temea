import 'package:flutter/material.dart';
import 'package:temea/models/models.dart';
import 'package:temea/theme/theme.dart';
import 'package:temea/utils/utils.dart';

import 'delete_category_dialog.dart';
import 'edit_category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      leading: Icon(
        Icons.square_rounded,
        size: 35,
        color: getCatColor(color: category.color, context: context),
      ),
      title: Text(
        category.name,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            color: appTheme.neutralButton,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => EditCategory(category: category),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            color: appTheme.dangerButton,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => DeleteCategoryDialog(category: category),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      onTap: () {
        // TODO: go to category stats?
      },
    );
  }
}
