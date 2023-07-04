import 'package:flutter/material.dart';

class DangerTextButton extends StatelessWidget {
  const DangerTextButton({super.key, this.onClick, required this.label});

  final Function()? onClick;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.error),
      child: Text(label),
    );
  }
}
