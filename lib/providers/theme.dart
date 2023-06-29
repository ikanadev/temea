import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temea/providers/shared_preferences.dart';
import 'package:temea/utils/utils.dart';

const themeKey = 'theme';

class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  FutureOr<ThemeMode> build() async {
    final SharedPreferences prefs = await ref.watch(prefsProvider.future);
    String? themeStr = prefs.getString(themeKey);
    if (themeStr == null) {
      return ThemeMode.system;
    } else {
      return strToThemeMode(themeStr);
    }
  }

  void setDarkMode() async {
    final SharedPreferences prefs = await ref.watch(prefsProvider.future);
    prefs.setString(themeKey, themeModeToStr(ThemeMode.dark));
    state = const AsyncValue.data(ThemeMode.dark);
  }

  void setLightMode() async {
    final SharedPreferences prefs = await ref.watch(prefsProvider.future);
    prefs.setString(themeKey, themeModeToStr(ThemeMode.light));
    state = const AsyncValue.data(ThemeMode.light);
  }

  void setSystemMode() async {
    final SharedPreferences prefs = await ref.watch(prefsProvider.future);
    prefs.setString(themeKey, themeModeToStr(ThemeMode.system));
    state = const AsyncValue.data(ThemeMode.system);
  }
}

final themeProvider = AsyncNotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
);
