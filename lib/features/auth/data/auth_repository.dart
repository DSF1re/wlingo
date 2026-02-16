import 'package:wlingo/features/auth/data/models/user/user.dart';

abstract class AuthRepository {
  Future<User?> getCurrentUser();

  Future<User> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  });

  Future<User> signIn({required String email, required String password});

  Future<void> signOut();

  Stream<User?> authStateChanges();
}
