import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

part 'get_all_users_usecase.g.dart';

@riverpod
GetAllUsersUseCase getAllUsersUseCase(Ref ref) {
  return GetAllUsersUseCase(ref.watch(authRepositoryProvider));
}

class GetAllUsersUseCase {
  final AuthRepository _repository;

  GetAllUsersUseCase(this._repository);

  Future<Either<AppFailure, List<UserEntity>>> call() {
    return _repository.getAllUsers();
  }
}
