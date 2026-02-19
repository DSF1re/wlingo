import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/data/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<Either<AuthFailure, User?>> getCurrentUser() async {
    try {
      final session = _client.auth.currentSession;
      final supaUser = session?.user;
      if (supaUser == null) return Left(AuthFailure.nullUser());

      final response = await _client
          .from('profiles')
          .select()
          .eq('id', supaUser.id)
          .maybeSingle();

      if (response == null) return Left(AuthFailure.nullUser());

      return Right(User.fromJson(response));
    } catch (e) {
      return Left(AuthFailure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, User>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  }) async {
    try {
      final authResponse = await _client.auth.signUp(
        email: email,
        password: password,
      );

      final supaUser = authResponse.user;
      if (supaUser == null) {
        return Left(AuthFailure.invalidCredentials());
      }

      final insertResponse = await _client
          .from('profiles')
          .insert({
            'id': supaUser.id,
            'first_name': firstName,
            'last_name': lastName,
            'mid_name': middleName,
            'mother_language': nativeLang,
            'is_admin': false,
          })
          .select()
          .single();

      return Right(User.fromJson(insertResponse));
    } on AuthException catch (e) {
      return switch (e.message) {
        'Email already registered' => Left(AuthFailure.emailAlreadyInUse()),
        'Invalid email' => Left(AuthFailure.invalidEmail()),
        _ => Left(AuthFailure.unexpected(e.message)),
      };
    } catch (e) {
      return Left(AuthFailure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final supaUser = authResponse.user;
      if (supaUser == null) {
        return Left(AuthFailure.invalidCredentials());
      }

      final response = await _client
          .from('profiles')
          .select()
          .eq('id', supaUser.id)
          .single();

      return Right(User.fromJson(response));
    } on AuthException catch (e) {
      return switch (e.message) {
        'Invalid login credentials' => Left(AuthFailure.invalidCredentials()),
        'Email not confirmed' => Left(AuthFailure.emailNotConfirmed()),
        _ => Left(AuthFailure.unexpected(e.message)),
      };
    } catch (e) {
      return Left(AuthFailure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await _client.auth.signOut();
      return Right(null);
    } catch (e) {
      return Left(AuthFailure.unexpected(e.toString()));
    }
  }

  @override
  Stream<Either<AuthFailure, User?>> authStateChanges() {
    return _client.auth.onAuthStateChange.asyncMap((event) async {
      try {
        final session = event.session;
        final supaUser = session?.user;
        if (supaUser == null) return Right(null);

        final response = await _client
            .from('profiles')
            .select()
            .eq('id', supaUser.id)
            .maybeSingle();

        if (response == null) return Right(null);

        return Right(User.fromJson(response));
      } catch (e) {
        return Left(AuthFailure.unexpected(e.toString()));
      }
    });
  }
}
