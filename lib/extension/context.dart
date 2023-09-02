import 'package:flutter/material.dart';
import 'package:temea/theme/theme.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  AppTheme get appTheme => theme.extension<AppTheme>()!;
}
