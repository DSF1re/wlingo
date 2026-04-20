import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wlingo/l10n/app_localizations.dart';

part 'auth_failure.freezed.dart';

@freezed
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.networkError() = _NetworkError;
  const factory AuthFailure.invalidCredentials() = _InvalidCredentials;
  const factory AuthFailure.unexpected(String message) = _Unexpected;
  const factory AuthFailure.nullUser() = _NullUser;
  const factory AuthFailure.emailNotConfirmed() = _EmailNotConfirmed;
  const factory AuthFailure.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AuthFailure.invalidEmail() = _InvalidEmail;
  const factory AuthFailure.fillForm() = _FillForm;
  const factory AuthFailure.fillAuth() = _FillAuth;
  const factory AuthFailure.fillEmail() = _FillEmail;
  const factory AuthFailure.fillPassword() = _FillPassword;
  const factory AuthFailure.invalidNameFormat() = _InvalidNameFormat;
}

extension AuthFailureStrings on AuthFailure {
  String toLocalizedMessage(AppLocalizations loc) {
    return when(
      networkError: () => loc.network_error,
      invalidCredentials: () => loc.invalid_credentials,
      unexpected: (message) => '${loc.error}: $message',
      nullUser: () => loc.user_not_found,
      emailNotConfirmed: () => loc.email_not_confirmed,
      emailAlreadyInUse: () => loc.email_already_in_use,
      invalidEmail: () => loc.invalid_email,
      fillForm: () => loc.fill_form,
      fillAuth: () => loc.fill_auth,
      fillEmail: () => loc.fill_email,
      fillPassword: () => loc.fill_password,
      invalidNameFormat: () => loc.invalid_name_format,
    );
  }
}
