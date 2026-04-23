import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wlingo/l10n/app_localizations.dart';

part 'app_failure.freezed.dart';

@freezed
sealed class AppFailure with _$AppFailure {
  const factory AppFailure.networkError() = _NetworkError;
  const factory AppFailure.invalidCredentials() = _InvalidCredentials;
  const factory AppFailure.unexpected(String message) = _Unexpected;
  const factory AppFailure.nullUser() = _NullUser;
  const factory AppFailure.emailNotConfirmed() = _EmailNotConfirmed;
  const factory AppFailure.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AppFailure.invalidEmail() = _InvalidEmail;
  const factory AppFailure.fillForm() = _FillForm;
  const factory AppFailure.fillAuth() = _FillAuth;
  const factory AppFailure.fillEmail() = _FillEmail;
  const factory AppFailure.fillPassword() = _FillPassword;
  const factory AppFailure.invalidNameFormat() = _InvalidNameFormat;
}

extension AppFailureStrings on AppFailure {
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
