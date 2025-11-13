import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wlingo/screens/auth_screen.dart';
import 'package:wlingo/screens/onboarding_screen.dart';
import 'package:wlingo/theme.dart';
import 'l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final localeNotifier = ValueNotifier(const Locale('ru'));
final themeModeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  supInit();

  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString('app_language') ?? 'ru';
  final savedThemeMode = prefs.getString('app_theme_mode') ?? 'light';

  localeNotifier.value = Locale(savedLanguage);
  themeModeNotifier.value = savedThemeMode == 'dark'
      ? ThemeMode.dark
      : ThemeMode.light;

  runApp(const MyApp());
}

Future<void> supInit() async {
  await Supabase.initialize(
    url: 'https://txamrwecbfhyxwmdhszc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR4YW1yd2VjYmZoeXh3bWRoc3pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1ODUxMzksImV4cCI6MjA3NTE2MTEzOX0.2kE4DXQH0gXQpKT_bK4qNi5qgJImrBaa8NGoy_AuuZ0',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder(
          valueListenable: localeNotifier,
          builder: (context, currentLocale, _) {
            return MaterialApp(
              title: 'Language App',
              locale: currentLocale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: const InitialScreen(),
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
            );
          },
        );
      },
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkOnboardingCompleted(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final isCompleted = snapshot.data ?? false;
        return isCompleted ? const AuthScreen() : const OnboardingScreen();
      },
    );
  }

  Future<bool> _checkOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') ?? false;
  }
}
