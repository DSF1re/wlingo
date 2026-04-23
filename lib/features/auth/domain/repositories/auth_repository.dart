import 'package:either_dart/either.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<AppFailure, UserEntity?>> getCurrentUser();

  Future<Either<AppFailure, UserEntity>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  });

  Future<Either<AppFailure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<AppFailure, UserEntity>> updateProfile({
    required String firstName,
    required String lastName,
    String? middleName,
  });

  Future<Either<AppFailure, void>> signOut();

  Future<Either<AppFailure, List<UserEntity>>> getAllUsers();

  Future<Either<AppFailure, List<Map<String, dynamic>>>> getUsersWithRatings();

  Future<Either<AppFailure, UserEntity>> updateProfileById({
    required String userId,
    required String firstName,
    required String lastName,
    String? middleName,
  });

  Stream<Either<AppFailure, UserEntity?>> authStateChanges();
}
