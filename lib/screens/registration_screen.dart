import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../l10n/app_localizations.dart';
import '../main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int? _selectedLanguageId;
  List<Map<String, dynamic>> _languages = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchLanguages();
  }

  Future<void> _fetchLanguages() async {
    final response = await Supabase.instance.client
        .from('languages')
        .select('id, name')
        .order('name');

    final List data = response.toList() as List? ?? [];
    setState(() {
      _languages = [
        for (var lang in data)
          {'id': lang['id'] as int, 'name': lang['name'] as String},
      ];
    });
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fill_field;
    }
    return null;
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
    if (value.length < 6) return AppLocalizations.of(context)!.min_lenght;
    return null;
  }

  // String? validateLanguage(int? value) {
  //   if (value == null) return 'Select native language';
  //   return null;
  // }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      // 1. Create user in auth
      final signUpResponse = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      final user = signUpResponse.user;
      if (user == null) throw Exception('Registration failed');

      // 2. Save profile
      await Supabase.instance.client.from('profiles').insert({
        'id': user.id,
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'mother_language': _selectedLanguageId,
      });

      // Показать snackbar и назад
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.reg_success,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        await Future.delayed(const Duration(milliseconds: 700));
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      log(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.reg_fail,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  static const String _languageKey = 'app_language';
  static const String _themeModeKey = 'app_theme_mode';

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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.registration),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // SizedBox(
                //   height: screenHeight * 0.2,
                //   child: Center(
                //     child: AspectRatio(
                //       aspectRatio: 1,
                //       child: Image.asset(
                //         'assets/images/select.png',
                //         fit: BoxFit.contain,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.reg_promo,
                  style: theme.textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _firstNameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.first_name,
                    hintStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  validator: validateName,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.last_name,
                    hintStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  validator: validateName,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.email,
                    hintStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.password,
                    hintStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  validator: validatePassword,
                ),
                const SizedBox(height: 16),
                DropdownMenu<int>(
                  width: double.infinity,
                  hintText: AppLocalizations.of(context)!.native_lang,
                  initialSelection: _selectedLanguageId,
                  dropdownMenuEntries: _languages
                      .map(
                        (lang) => DropdownMenuEntry(
                          value: lang['id'] as int,
                          label: lang['name'] as String,
                          style: MenuItemButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                        ),
                      )
                      .toList(),
                  onSelected: (val) {
                    setState(() {
                      _selectedLanguageId = val;
                    });
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _loading ? null : _register,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : Text(AppLocalizations.of(context)!.sign_up),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
