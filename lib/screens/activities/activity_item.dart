import 'package:flutter/material.dart';
import 'package:temea/models/models.dart';
import 'package:temea/theme/theme.dart';
import 'package:temea/utils/utils.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({super.key, required this.act});
  final Activity act;

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    final iconColor = getCatColor(
      color: act.category?.color ?? CategoryColor.grey,
      context: context,
    );
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      title: Text(act.name),
      subtitle: Text(act.category?.name ?? 'No category'),
      leading: Icon(
        getIconData(act.iconName),
        color: iconColor,
        size: 40,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: appTheme.neutralButton,
            onPressed: () {
              //
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: appTheme.dangerButton,
            onPressed: () {
              //
            },
          ),
        ],
      ),
    );
  }
}
