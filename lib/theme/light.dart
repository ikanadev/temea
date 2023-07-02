import 'package:flutter/material.dart';

import 'app_theme.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  extensions: <ThemeExtension>[
    AppTheme.ligth,
  ],
);
