import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/global_variables/services.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPrefsProvider);
    final savedMode = prefs.getString('app_theme_mode') == 'dark'
        ? ThemeMode.dark
        : ThemeMode.light;
    return savedMode;
  }

  void toggleTheme() {
    final prefs = ref.read(sharedPrefsProvider);
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      prefs.setString('app_theme_mode', 'light');
    } else {
      state = ThemeMode.dark;
      prefs.setString('app_theme_mode', 'dark');
    }
  }
}
