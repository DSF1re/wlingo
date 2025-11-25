import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:wlingo/core/repositories/auth_repository.dart';
import 'package:wlingo/core/repositories/language_repository.dart';
import 'package:wlingo/core/repositories/options_repository.dart';
import 'package:wlingo/models/language.dart';
import 'package:wlingo/utils/validators.dart';
import '../l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AuthRepository _authRepository;
  late LanguageRepository _languageRepository;
  late OptionsRepository _optionsRepository;

  int? _selectedLanguageId;
  List<Language> _languages = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _initializeRepositories();
    _fetchLanguages();
  }

  void _initializeRepositories() {
    _authRepository = GetIt.I<AuthRepository>();
    _languageRepository = GetIt.I<LanguageRepository>();
    _optionsRepository = GetIt.I<OptionsRepository>();
  }

  Future<void> _fetchLanguages() async {
    try {
      final languages = await _languageRepository.fetchLanguages();
      setState(() => _languages = languages);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate() || _selectedLanguageId == null) {
      return;
    }

    setState(() => _loading = true);
    try {
      await _authRepository.signUp(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        motherLanguageId: _selectedLanguageId!,
      );

      if (mounted) {
        _showSuccessSnackBar();
        await Future.delayed(const Duration(milliseconds: 700));
        if (mounted) Navigator.of(context).pop();
      }
    } catch (e) {
      log(e.toString());
      if (mounted) _showErrorSnackBar();
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.reg_success),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.reg_fail),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.registration),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        actions: [
          IconButton(
            onPressed: _optionsRepository.toggleLanguage,
            icon: const Icon(Icons.language),
          ),
          IconButton(
            onPressed: _optionsRepository.toggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  AppLocalizations.of(context)!.reg_promo,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _firstNameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.first_name,
                  ),
                  validator: (val) => FormValidators.validateName(val, context),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.last_name,
                  ),
                  validator: (val) => FormValidators.validateName(val, context),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.email,
                  ),
                  validator: (val) =>
                      FormValidators.validateEmail(val, context),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.password,
                  ),
                  validator: (val) =>
                      FormValidators.validatePassword(val, context),
                ),
                const SizedBox(height: 16),
                DropdownMenu<int>(
                  width: double.infinity,
                  hintText: AppLocalizations.of(context)!.native_lang,
                  initialSelection: _selectedLanguageId,
                  dropdownMenuEntries: _languages
                      .map(
                        (lang) =>
                            DropdownMenuEntry(value: lang.id, label: lang.name),
                      )
                      .toList(),
                  onSelected: (val) =>
                      setState(() => _selectedLanguageId = val),
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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
