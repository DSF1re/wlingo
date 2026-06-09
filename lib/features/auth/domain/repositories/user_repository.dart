import 'package:either_dart/either.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<AppFailure, UserEntity>> updateProfile({
    required String userId,
    required String firstName,
    required String lastName,
    String? middleName,
  });

  Future<Either<AppFailure, List<UserEntity>>> getAllUsers();

  Future<Either<AppFailure, List<Map<String, dynamic>>>> getUsersWithRatings();

  Future<Either<AppFailure, UserEntity>> updateProfileById({
    required String userId,
    required String firstName,
    required String lastName,
    String? middleName,
  });

  Future<Either<AppFailure, void>> addXP({
    required String userId,
    required int amount,
  });

  Future<Either<AppFailure, void>> updateStreakData({
    required String userId,
    required int streak,
    required DateTime streakLastDate,
  });
}
