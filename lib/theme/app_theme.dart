import 'package:flutter/material.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    required this.greyText,
  });

  final Color? greyText;

  @override
  ThemeExtension<AppTheme> copyWith({Color? greyText}) {
    return AppTheme(greyText: greyText ?? this.greyText);
  }

  @override
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      greyText: Color.lerp(greyText, other.greyText, t),
    );
  }

  static var ligth = AppTheme(
    greyText: Colors.grey[600],
  );
  static var dark = AppTheme(
    greyText: Colors.grey[400],
  );
}

AppTheme getAppTheme(BuildContext context) =>
    Theme.of(context).extension<AppTheme>()!;
