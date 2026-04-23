import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

part 'sign_up_usecase.g.dart';

@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
}

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<AppFailure, UserEntity>> call({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  }) {
    return _repository.signUp(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      nativeLang: nativeLang,
    );
  }
}
