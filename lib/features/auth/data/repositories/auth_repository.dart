import 'package:either_dart/either.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, User?>> getCurrentUser();

  Future<Either<AuthFailure, User>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  });

  Future<Either<AuthFailure, User>> signIn({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, void>> signOut();

  Stream<Either<AuthFailure, User?>> authStateChanges();
}
