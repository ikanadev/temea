import 'package:flutter/material.dart';
import 'package:temea/theme/theme.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    scrolledUnderElevation: 0,
  ),
  extensions: <ThemeExtension>[
    AppTheme.dark,
  ],
);
