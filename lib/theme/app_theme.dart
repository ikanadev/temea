import 'package:flutter/material.dart';

@immutable
class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    this.greyText,
    this.dangerButton,
    this.neutralButton,
  });

  final Color? greyText;
  final Color? dangerButton;
  final Color? neutralButton;

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? greyText,
    Color? dangerButton,
    Color? neutralButton,
  }) {
    return AppTheme(
      greyText: greyText ?? this.greyText,
      dangerButton: dangerButton ?? this.dangerButton,
      neutralButton: neutralButton ?? this.neutralButton,
    );
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
      dangerButton: Color.lerp(dangerButton, other.dangerButton, t),
      neutralButton: Color.lerp(neutralButton, other.neutralButton, t),
    );
  }

  static var ligth = AppTheme(
    greyText: Colors.grey[600],
    dangerButton: Colors.red[400],
    neutralButton: Colors.grey,
  );
  static var dark = AppTheme(
    greyText: Colors.grey[400],
    dangerButton: Colors.red[700],
    neutralButton: Colors.grey[600],
  );
}

AppTheme getAppTheme(BuildContext context) =>
    Theme.of(context).extension<AppTheme>()!;
