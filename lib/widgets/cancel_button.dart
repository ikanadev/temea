import 'package:flutter/material.dart';
import 'package:temea/theme/theme.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, required this.label, required this.onClick});

  final String label;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return TextButton(
      onPressed: onClick,
      child: Text(label, style: TextStyle(color: appTheme.greyText)),
    );
  }
}
