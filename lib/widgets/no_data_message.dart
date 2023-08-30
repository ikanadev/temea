import 'package:flutter/material.dart';
import 'package:temea/theme/theme.dart';

class NoDataMessage extends StatelessWidget {
  const NoDataMessage(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    final appTheme = getAppTheme(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Text(
        message,
        style: TextStyle(
          color: appTheme.greyText,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
