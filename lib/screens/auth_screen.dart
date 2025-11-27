import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/core/repositories/auth_repository.dart';
import 'package:wlingo/core/repositories/options_repository.dart';
import 'package:wlingo/screens/home_screen.dart';
import 'package:wlingo/services/preferences_service.dart';
import 'package:wlingo/utils/validators.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/screens/onboarding_screen.dart';
import 'package:wlingo/screens/registration_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  late AuthRepository _authRepository;
  late PreferencesService _preferencesService;
  late OptionsRepository _optionsRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = GetIt.I<AuthRepository>();
    _preferencesService = GetIt.I<PreferencesService>();
    _optionsRepository = GetIt.I<OptionsRepository>();
  }

  Future<void> _goBackToOnboarding() async {
    await _preferencesService.saveOnboardingCompleted(false);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Theme.of(context).textTheme.displaySmall),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authRepository.signIn(
        _emailController.text,
        _passwordController.text,
      );
      if (response.user != null && mounted) {
        log('User signed in: ${response.user?.email}');
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    } on AuthException catch (error) {
      if (context.mounted) {
        if (error.message == 'Invalid login credentials' && mounted) {
          _showErrorSnackBar(AppLocalizations.of(context)!.user_not_found);
        } else if (error.message.contains('Email not confirmed') && mounted) {
          _showErrorSnackBar(AppLocalizations.of(context)!.email_not_confirmed);
        } else if (error.message.contains('User not found') && mounted) {
          _showErrorSnackBar(AppLocalizations.of(context)!.user_not_found);
        } else {
          log('Error: ${error.message}');
          _showErrorSnackBar('Произошла ошибка!');
        }
      }
    } catch (_) {
      _showErrorSnackBar('Произошла ошибка!');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
            onPressed: _optionsRepository.toggleLanguage,
            icon: const Icon(Icons.translate),
          ),
          IconButton(
            onPressed: _optionsRepository.toggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
        ],
        leading: IconButton(
          onPressed: _goBackToOnboarding,
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Stack(
        children: [
          // ТВОЙ ТЕКУЩИЙ КОНТЕНТ
          PopScope(
            canPop: false,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.22,
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
                        const SizedBox(height: 8),
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(25),
                          ],
                          validator: (val) =>
                              FormValidators.validateEmail(val, context),
                        ),
                        const SizedBox(height: 8),
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(25),
                          ],
                          validator: (val) =>
                              FormValidators.validatePassword(val, context),
                        ),
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
                        const SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _login,
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : () {
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

          if (_isLoading)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black54,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
