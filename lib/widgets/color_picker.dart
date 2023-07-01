import 'package:flutter/material.dart';
import 'package:temea/utils/utils.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
    required this.color,
    required this.onSelect,
  });

  final CategoryColor color;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color'),
      content: const Text('Not implemented yet!'),
    );
  }
}
