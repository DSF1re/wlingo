import 'package:wlingo/l10n/app_localizations.dart';

sealed class AuthFailure {
  factory AuthFailure.networkError() => NetworkAuthFailure();
  factory AuthFailure.invalidCredentials() => InvalidCredentialsFailure();
  factory AuthFailure.unexpected(String message) => UnexpectedFailure(message);
  factory AuthFailure.nullUser() => UserNotFound();
  factory AuthFailure.emailNotConfirmed() => EmailNotConfirmedFailure();
  factory AuthFailure.emailAlreadyInUse() => EmailAlredyInUse();
  factory AuthFailure.invalidEmail() => InvalidEmail();
  const AuthFailure();
}

extension AuthFailureStrings on AuthFailure {
  String toLocalizedMessage(AppLocalizations loc) {
    return switch (this) {
      InvalidCredentialsFailure() => loc.invalid_credentials,
      EmailNotConfirmedFailure() => loc.email_not_confirmed,
      UserNotFound() => loc.user_not_found,
      EmailAlredyInUse() => loc.email_already_in_use,
      InvalidEmail() => loc.invalid_email,
      NetworkAuthFailure() => loc.network_error,
      _ => loc.error,
    };
  }
}

class NetworkAuthFailure extends AuthFailure {}

class InvalidCredentialsFailure extends AuthFailure {}

class UnexpectedFailure extends AuthFailure {
  final String message;
  UnexpectedFailure(this.message);
}

class UserNotFound extends AuthFailure {}

class EmailNotConfirmedFailure extends AuthFailure {}

class EmailAlredyInUse extends AuthFailure {}

class InvalidEmail extends AuthFailure {}
