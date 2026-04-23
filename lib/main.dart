import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';
import 'package:wlingo/app.dart';
import 'package:wlingo/core/global_variables/services.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  final prefs = await SharedPreferences.getInstance();
  await supabaseInitialize();
  Intl.defaultLocale = 'ru_RU';

  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      observers: [TalkerRiverpodObserver(talker: talker)],
      child: const MainApp(),
    ),
  );
}
