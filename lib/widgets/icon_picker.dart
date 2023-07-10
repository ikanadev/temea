import 'package:flutter/material.dart';
import 'package:temea/utils/utils.dart';

class IconPicker extends StatelessWidget {
  const IconPicker({
    super.key,
    required this.iconName,
    required this.setIconName,
  });
  final String iconName;
  final ValueChanged<String> setIconName;

  void _closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconNames = iconsMap.keys;
    return Dialog.fullscreen(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Expanded(
                  child:
                      Text('Pick an Icon', style: theme.textTheme.titleLarge),
                ),
                IconButton(
                  onPressed: () => _closeDialog(context),
                  icon: const Icon(Icons.close),
                  iconSize: 40,
                ),
              ],
            ),
          ),
          Expanded(
              child: GridView.builder(
            itemCount: iconNames.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (context, index) {
              final currentIcon = iconNames.elementAt(index);
              final icon = Icon(getIconData(iconNames.elementAt(index)));
              if (currentIcon == iconName) {
                return IconButton.filledTonal(
                  onPressed: null,
                  icon: icon,
                  iconSize: 30,
                );
              } else {
                return IconButton(
                  onPressed: () {
                    setIconName(currentIcon);
                    _closeDialog(context);
                  },
                  icon: icon,
                  iconSize: 30,
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
