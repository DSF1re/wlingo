import 'package:flutter/material.dart';
import 'package:wlingo/main.dart';
import 'package:wlingo/services/preferences_service.dart';

class OptionsRepository {
  final PreferencesService _preferencesService;

  OptionsRepository(this._preferencesService);

  Future<void> toggleLanguage() async {
    final newLocale = localeNotifier.value.languageCode == 'ru'
        ? const Locale('en')
        : const Locale('ru');
    localeNotifier.value = newLocale;
    await _preferencesService.saveLanguage(newLocale.languageCode);
  }

  String getCurrentLanguageCode() {
    return localeNotifier.value.languageCode;
  }

  Future<void> toggleTheme() async {
    final newThemeMode = themeModeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    themeModeNotifier.value = newThemeMode;
    await _preferencesService.saveThemeMode(
      newThemeMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
