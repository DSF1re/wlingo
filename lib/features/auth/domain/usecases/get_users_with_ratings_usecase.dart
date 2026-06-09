import 'package:either_dart/either.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/repositories/user_repository.dart';

class GetUsersWithRatingsUseCase {
  final UserRepository _repository;

  GetUsersWithRatingsUseCase(this._repository);

  Future<Either<AppFailure, List<Map<String, dynamic>>>> call() {
    return _repository.getUsersWithRatings();
  }
}
