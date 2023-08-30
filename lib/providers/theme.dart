import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temea/providers/shared_preferences.dart';
import 'package:temea/utils/utils.dart';

const themeKey = 'theme';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPrefsProvider);
    String? themeStr = prefs.getString(themeKey);
    if (themeStr == null) {
      return ThemeMode.system;
    } else {
      return strToThemeMode(themeStr);
    }
  }

  void setDarkMode() {
    final prefs = ref.watch(sharedPrefsProvider);
    prefs.setString(themeKey, themeModeToStr(ThemeMode.dark));
    state = ThemeMode.dark;
  }

  void setLightMode() async {
    final prefs = ref.watch(sharedPrefsProvider);
    prefs.setString(themeKey, themeModeToStr(ThemeMode.light));
    state = ThemeMode.light;
  }

  void setSystemMode() {
    final prefs = ref.watch(sharedPrefsProvider);
    prefs.setString(themeKey, themeModeToStr(ThemeMode.system));
    state = ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) {
    final prefs = ref.watch(sharedPrefsProvider);
    prefs.setString(themeKey, themeModeToStr(mode));
    state = mode;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
);
