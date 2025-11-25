// lib/utils/validators.dart
import 'package:flutter/widgets.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class FormValidators {
  static String? validateName(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fill_field;
    }
    return null;
  }

  static String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fill_email;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.invalid_email;
    }
    return null;
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fill_password;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.min_lenght;
    }
    return null;
  }
}
