import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart' as model;
import 'package:wlingo/features/auth/data/models/user/user_mapper.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseClient get _client => Supabase.instance.client;

  AuthFailure _handleException(Object e) {
    if (e is SocketException || e is HttpException) {
      return AuthFailure.networkError();
    }

    if (e is AuthException) {
      final msg = e.message.toLowerCase();

      if (msg.contains('invalid login credentials')) {
        return AuthFailure.invalidCredentials();
      }
      if (msg.contains('email not confirmed')) {
        return AuthFailure.emailNotConfirmed();
      }
      if (msg.contains('already registered') ||
          msg.contains('already in use')) {
        return AuthFailure.emailAlreadyInUse();
      }
      return AuthFailure.unexpected(e.message);
    }

    if (e is PostgrestException) {
      if (e.code == 'PGRST' ||
          e.message.contains('SocketException') ||
          e.code == '08006') {
        return AuthFailure.networkError();
      }
      return AuthFailure.unexpected(e.message);
    }

    return AuthFailure.unexpected(e.toString());
  }

  @override
  Future<Either<AuthFailure, UserEntity?>> getCurrentUser() async {
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
      return Right(model.User.fromJson(response).toEntity());
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  }) async {
    try {
      if (email.isEmpty ||
          password.isEmpty ||
          firstName.isEmpty ||
          lastName.isEmpty) {
        return Left(AuthFailure.fillForm());
      }

      final authResponse = await _client.auth.signUp(
        email: email,
        password: password,
      );

      final supaUser = authResponse.user;
      if (supaUser == null) return Left(AuthFailure.invalidCredentials());

      final insertResponse = await _client
          .from('profiles')
          .insert({
            'id': supaUser.id,
            'first_name': firstName,
            'last_name': lastName,
            'mid_name': middleName,
            'mother_language': nativeLang,
            'isAdmin': false,
          })
          .select()
          .single();

      return Right(model.User.fromJson(insertResponse).toEntity());
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return Left(AuthFailure.fillAuth());
      }

      final authResponse = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final supaUser = authResponse.user;
      if (supaUser == null) return Left(AuthFailure.nullUser());

      final response = await _client
          .from('profiles')
          .select()
          .eq('id', supaUser.id)
          .single();

      return Right(model.User.fromJson(response).toEntity());
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> updateProfile({
    required String firstName,
    required String lastName,
    String? middleName,
  }) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return Left(AuthFailure.nullUser());

      final response = await _client
          .from('profiles')
          .update({
            'first_name': firstName,
            'last_name': lastName,
            'mid_name': middleName,
          })
          .eq('id', userId)
          .select()
          .single();

      return Right(model.User.fromJson(response).toEntity());
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await _client.auth.signOut();
      return Right(null);
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, List<UserEntity>>> getAllUsers() async {
    try {
      final response = await _client.from('profiles').select();

      final List<dynamic> data = response as List<dynamic>;
      return Right(
        data.map((json) => model.User.fromJson(json).toEntity()).toList(),
      );
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, List<Map<String, dynamic>>>>
      getUsersWithRatings() async {
    try {
      final response = await _client.from('profiles').select('*, rating(points)');

      final List<dynamic> data = response as List<dynamic>;
      return Right(data.cast<Map<String, dynamic>>());
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> updateProfileById({
    required String userId,
    required String firstName,
    required String lastName,
    String? middleName,
  }) async {
    try {
      final response = await _client
          .from('profiles')
          .update({
            'first_name': firstName,
            'last_name': lastName,
            'mid_name': middleName,
          })
          .eq('id', userId)
          .select()
          .single();

      return Right(model.User.fromJson(response).toEntity());
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Stream<Either<AuthFailure, UserEntity?>> authStateChanges() {
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

        return Right(model.User.fromJson(response).toEntity());
      } catch (e) {
        return Left(_handleException(e));
      }
    });
  }
}
