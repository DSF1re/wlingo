import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/main.dart';
import 'package:wlingo/screens/onboarding_screen.dart';
import 'package:wlingo/screens/registration_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _obscurePassword = true;

  // Финальные поля-контроллеры!
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // SharedPreferences ключи
  static const String _languageKey = 'app_language';
  static const String _themeModeKey = 'app_theme_mode';
  static const String _onboardingCompletedKey = 'onboarding_completed';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Сохранить язык
  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  // Сохранить тему
  Future<void> _saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode);
  }

  void _toggleLanguage() async {
    final newLocale = localeNotifier.value.languageCode == 'ru'
        ? const Locale('en')
        : const Locale('ru');
    localeNotifier.value = newLocale;
    await _saveLanguage(newLocale.languageCode);
  }

  void _toggleTheme() async {
    final newThemeMode = themeModeNotifier.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    themeModeNotifier.value = newThemeMode;
    await _saveThemeMode(newThemeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  void _goBackToOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, false);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fill_email;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.invalid_email;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fill_password;
    }
    return null;
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Theme.of(context).textTheme.displaySmall),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
        actions: [
          IconButton(
            onPressed: _toggleLanguage,
            icon: const Icon(Icons.language),
          ),
          IconButton(
            onPressed: _toggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
        ],
        leading: IconButton(
          onPressed: _goBackToOnboarding,
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: PopScope(
        canPop: false,
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Верхняя часть с логотипом
                  SizedBox(
                    height: screenHeight * 0.21,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          'assets/images/splash.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.promo_auth,
                        style: theme.textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // Поле Email
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.email_address,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.email,
                          hintStyle: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(25)],
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 8),
                      // Поле Password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.password,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        obscureText: _obscurePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.password,
                          hintStyle: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0x65687280),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(25)],
                        validator: validatePassword,
                      ),
                      // Forgot Password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.forgot_pass,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(233, 214, 24, 94),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Кнопка входа
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                final response = await Supabase
                                    .instance
                                    .client
                                    .auth
                                    .signInWithPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                if (response.user != null) {
                                  log(
                                    'User signed in: ${response.user?.email}',
                                  );
                                }
                              } on AuthException catch (error) {
                                if (context.mounted) {
                                  if (error.message ==
                                      'Invalid login credentials') {
                                    showErrorSnackBar(
                                      AppLocalizations.of(
                                        context,
                                      )!.user_not_found,
                                    );
                                  } else if (error.message.contains(
                                    'Email not confirmed',
                                  )) {
                                    showErrorSnackBar(
                                      AppLocalizations.of(
                                        context,
                                      )!.email_not_confirmed,
                                    );
                                  } else if (error.message.contains(
                                    'User not found',
                                  )) {
                                    showErrorSnackBar(
                                      AppLocalizations.of(
                                        context,
                                      )!.user_not_found,
                                    );
                                  } else {
                                    log('Error: ${error.message}');
                                  }
                                }
                              } catch (error) {
                                showErrorSnackBar('Произошла ошибка!');
                              }
                            } else {
                              if (validateEmail(_emailController.text) !=
                                  null) {
                                showErrorSnackBar(
                                  validateEmail(_emailController.text)!,
                                );
                              } else if (validatePassword(
                                    _passwordController.text,
                                  ) !=
                                  null) {
                                showErrorSnackBar(
                                  validatePassword(_passwordController.text)!,
                                );
                              }
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.create_account,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(233, 24, 119, 214),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
