import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/main.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final locale = shared.getString('app_language') == 'ru'
        ? Locale('ru')
        : Locale('en');
    return locale;
  }

  void toggleLocale() {
    if (state == Locale('ru')) {
      state = Locale('en');
      shared.setString('app_language', 'en');
    } else {
      state = Locale('ru');
      shared.setString('app_language', 'ru');
    }
  }
}
