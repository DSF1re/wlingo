import 'package:either_dart/either.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/domain/repositories/user_repository.dart';

class AddXPUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AddXPUseCase(this._authRepository, this._userRepository);

  Future<Either<AppFailure, void>> call(int amount) async {
    final userResult = await _authRepository.getCurrentUser();
    return userResult.fold(
      (failure) => Left(failure),
      (user) {
        if (user == null) {
          return const Left(AppFailure.nullUser());
        }
        return _userRepository.addXP(userId: user.id, amount: amount);
      },
    );
  }
}
