import 'package:flutter/material.dart';
import 'package:temea/theme/theme.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  extensions: <ThemeExtension>[
    AppTheme.dark,
  ],
);
