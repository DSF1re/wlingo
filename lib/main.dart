import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger_observer.dart';
import 'package:wlingo/core/public_vars.dart';
import 'package:wlingo/core/router.dart';
import 'package:wlingo/core/supa_init.dart';
import 'package:wlingo/features/onboarding/domain/providers/locale/locale_provider.dart';
import 'package:wlingo/features/onboarding/domain/providers/theme/theme_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';

late final SharedPreferences shared;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shared = await SharedPreferences.getInstance();
  supabaseInitialize();
  Intl.defaultLocale = 'ru_RU';
  final talker = TalkerFlutter.init();
  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: talker)],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final thememode = ref.watch(themeProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        themeMode: thememode,
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: ref.read(routerProvider),
        locale: locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
