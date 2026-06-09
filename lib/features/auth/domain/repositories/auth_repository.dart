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

  Future<Either<AppFailure, void>> signOut();

  Stream<Either<AppFailure, UserEntity?>> authStateChanges();
}
