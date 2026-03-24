import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';
import 'package:wlingo/app.dart';
import 'package:wlingo/core/global_variables/supa_init.dart';

late final SharedPreferences shared;
final talker = TalkerFlutter.init();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shared = await SharedPreferences.getInstance();
  supabaseInitialize();
  Intl.defaultLocale = 'ru_RU';
  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: talker)],
      child: const MainApp(),
    ),
  );
}
