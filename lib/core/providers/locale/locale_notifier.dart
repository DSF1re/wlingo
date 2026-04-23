import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/global_variables/services.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.read(sharedPrefsProvider);
    final locale = prefs.getString('app_language') == 'ru'
        ? Locale('ru')
        : Locale('en');
    return locale;
  }

  void toggleLocale() {
    final prefs = ref.read(sharedPrefsProvider);
    if (state == Locale('ru')) {
      state = Locale('en');
      prefs.setString('app_language', 'en');
    } else {
      state = Locale('ru');
      prefs.setString('app_language', 'ru');
    }
  }
}
