import 'package:flutter/material.dart';
import 'package:temea/utils/utils.dart';
import 'package:temea/widgets/widgets.dart';

class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton({
    super.key,
    required this.color,
    required this.onSelect,
  });
  final CategoryColor color;
  final ValueChanged<CategoryColor> onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => ColorPicker(color: color, onSelect: onSelect),
        );
      },
      child: Container(
        width: 38,
        height: 25,
        decoration: BoxDecoration(
          color: getCatColor(color: color, context: context),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
      ),
    );
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key, required this.color, required this.onSelect});
  final CategoryColor color;
  final ValueChanged<CategoryColor> onSelect;

  void _closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _pickColor(BuildContext context, CategoryColor color) {
    onSelect(color);
    _closeDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 180,
            width: 200,
            child: GridView.count(
              crossAxisCount: 4,
              // padding: const EdgeInsets.all(20),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: CategoryColor.values
                  .map((catCol) => InkWell(
                        onTap: () => _pickColor(context, catCol),
                        child: Container(
                          decoration: BoxDecoration(
                            color: getCatColor(color: catCol, context: context),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      actions: [
        CancelButton(label: 'Cancel', onClick: () => _closeDialog(context))
      ],
    );
  }
}
