import 'package:either_dart/either.dart';
import 'package:wlingo/core/failure/auth_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, UserEntity?>> getCurrentUser();

  Future<Either<AuthFailure, UserEntity>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  });

  Future<Either<AuthFailure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, UserEntity>> updateProfile({
    required String firstName,
    required String lastName,
    String? middleName,
  });

  Future<Either<AuthFailure, void>> signOut();

  Future<Either<AuthFailure, List<UserEntity>>> getAllUsers();

  Future<Either<AuthFailure, List<Map<String, dynamic>>>> getUsersWithRatings();

  Future<Either<AuthFailure, UserEntity>> updateProfileById({
    required String userId,
    required String firstName,
    required String lastName,
    String? middleName,
  });

  Stream<Either<AuthFailure, UserEntity?>> authStateChanges();
}
