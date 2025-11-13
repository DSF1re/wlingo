import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wlingo/screens/auth_screen.dart';
import 'package:wlingo/screens/onboarding_screen.dart';
import 'package:wlingo/theme.dart';
import 'l10n/app_localizations.dart';

final localeNotifier = ValueNotifier(const Locale('ru'));
final themeModeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Загрузить сохраненные настройки
  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString('app_language') ?? 'ru';
  final savedThemeMode = prefs.getString('app_theme_mode') ?? 'light';

  localeNotifier.value = Locale(savedLanguage);
  themeModeNotifier.value = savedThemeMode == 'dark'
      ? ThemeMode.dark
      : ThemeMode.light;

  runApp(const MyApp());
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
              home: const InitialScreen(), // Определяем стартовый экран
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

// Виджет для определения начального экрана
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

        // Если онбординг завершен - показываем AuthScreen, иначе - OnboardingScreen
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
