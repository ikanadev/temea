import 'package:flutter/material.dart';

const _dark = 'DARK';
const _light = 'LIGHT';
const _system = 'SYSTEM';

// This utility is meant to use it exclusively with shared preferences
String themeModeToStr(ThemeMode theme) {
  switch (theme) {
    case ThemeMode.dark:
      return _dark;
    case ThemeMode.light:
      return _light;
    case ThemeMode.system:
      return _system;
  }
}

// This utility is meant to use it exclusively with shared preferences
ThemeMode strToThemeMode(String value) {
  switch (value) {
    case _dark:
      return ThemeMode.dark;
    case _light:
      return ThemeMode.light;
    case _system:
      return ThemeMode.system;
    default:
      return ThemeMode.system;
  }
}
