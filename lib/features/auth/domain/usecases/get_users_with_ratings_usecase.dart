import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

part 'get_users_with_ratings_usecase.g.dart';

@riverpod
GetUsersWithRatingsUseCase getUsersWithRatingsUseCase(Ref ref) {
  return GetUsersWithRatingsUseCase(ref.watch(authRepositoryProvider));
}

class GetUsersWithRatingsUseCase {
  final AuthRepository _repository;

  GetUsersWithRatingsUseCase(this._repository);

  Future<Either<AuthFailure, List<Map<String, dynamic>>>> call() {
    return _repository.getUsersWithRatings();
  }
}
