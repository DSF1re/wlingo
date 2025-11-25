import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wlingo/screens/auth_screen.dart';
import 'package:wlingo/screens/onboarding_screen.dart';
import 'package:wlingo/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/service_locator.dart';

final localeNotifier = ValueNotifier(const Locale('ru'));
final themeModeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await supInit();

  await setupServiceLocator();

  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString('app_language') ?? 'ru';
  final savedThemeMode = prefs.getString('app_theme_mode') ?? 'dark';

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
              theme: buildAppTheme(brightness: Brightness.light),
              darkTheme: buildAppTheme(brightness: Brightness.dark),
              themeMode: themeModeNotifier.value,
            );
          },
        );
      },
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() async {
    final prefs = await SharedPreferences.getInstance();
    final isCompleted = prefs.getBool('onboarding_completed') ?? false;
    if (isCompleted && mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthScreen()));
    } else {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
