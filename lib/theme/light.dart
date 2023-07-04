import 'package:flutter/material.dart';

import 'app_theme.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade50,
    scrolledUnderElevation: 0,
  ),
  extensions: <ThemeExtension>[
    AppTheme.ligth,
  ],
);
