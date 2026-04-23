import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

part 'sign_out_usecase.g.dart';

@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
}

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<AppFailure, void>> call() {
    return _repository.signOut();
  }
}
