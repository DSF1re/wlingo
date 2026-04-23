import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart' as model;
import 'package:wlingo/features/auth/data/models/user/user_mapper.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseClient get _client => Supabase.instance.client;

  AppFailure _handleException(Object e) {
    if (e is AppFailure) return e;
    if (e is SocketException ||
        e is HttpException ||
        e is HandshakeException ||
        e is TlsException) {
      return const AppFailure.networkError();
    }

    if (e is AuthException) {
      if (e is AuthRetryableFetchException) {
        return const AppFailure.networkError();
      }
      final msg = e.message.toLowerCase();

      if (msg.contains('invalid login credentials')) {
        return const AppFailure.invalidCredentials();
      }
      if (msg.contains('email not confirmed')) {
        return const AppFailure.emailNotConfirmed();
      }
      if (msg.contains('already registered') ||
          msg.contains('already in use')) {
        return const AppFailure.emailAlreadyInUse();
      }
      return AppFailure.unexpected(e.message);
    }

    if (e is PostgrestException) {
      if (e.code == 'PGRST' ||
          e.message.contains('SocketException') ||
          e.code == '08006') {
        return const AppFailure.networkError();
      }
      return AppFailure.unexpected(e.message);
    }

    return AppFailure.unexpected(e.toString());
  }

  Future<Either<AppFailure, T>> _safeCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Right(result);
    } catch (e, st) {
      talker.handle(e, st, 'SupabaseAuthRepository Error');
      return Left(_handleException(e));
    }
  }

  Future<UserEntity> _getProfileAndToEntity(String userId) async {
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return model.User.fromJson(response).toEntity();
  }

  @override
  Future<Either<AppFailure, UserEntity?>> getCurrentUser() async {
    return _safeCall(() async {
      final supaUser = _client.auth.currentUser;
      if (supaUser == null) return null;

      final response = await _client
          .from('profiles')
          .select()
          .eq('id', supaUser.id)
          .maybeSingle();

      if (response == null) return null;
      return model.User.fromJson(response).toEntity();
    });
  }

  @override
  Future<Either<AppFailure, UserEntity>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  }) async {
    return _safeCall(() async {
      if (email.isEmpty ||
          password.isEmpty ||
          firstName.isEmpty ||
          lastName.isEmpty) {
        throw const AppFailure.fillForm();
      }

      final authResponse = await _client.auth.signUp(
        email: email,
        password: password,
      );

      final supaUser = authResponse.user;
      if (supaUser == null) throw const AppFailure.invalidCredentials();

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

      return model.User.fromJson(insertResponse).toEntity();
    });
  }

  @override
  Future<Either<AppFailure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    return _safeCall(() async {
      if (email.isEmpty || password.isEmpty) {
        throw const AppFailure.fillAuth();
      }

      final authResponse = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final supaUser = authResponse.user;
      if (supaUser == null) throw const AppFailure.nullUser();

      return _getProfileAndToEntity(supaUser.id);
    });
  }

  @override
  Future<Either<AppFailure, UserEntity>> updateProfile({
    required String firstName,
    required String lastName,
    String? middleName,
  }) async {
    return _safeCall(() async {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) throw const AppFailure.nullUser();

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

      return model.User.fromJson(response).toEntity();
    });
  }

  @override
  Future<Either<AppFailure, void>> signOut() async {
    return _safeCall(() => _client.auth.signOut());
  }

  @override
  Future<Either<AppFailure, List<UserEntity>>> getAllUsers() async {
    return _safeCall(() async {
      final response = await _client
          .from('profiles')
          .select()
          .order('created_at', ascending: false)
          .limit(50);
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => model.User.fromJson(json).toEntity()).toList();
    });
  }

  @override
  Future<Either<AppFailure, List<Map<String, dynamic>>>>
  getUsersWithRatings() async {
    return _safeCall(() async {
      final response = await _client
          .from('profiles')
          .select('*, rating(points)');
      final List<dynamic> data = response as List<dynamic>;
      return data.cast<Map<String, dynamic>>();
    });
  }

  @override
  Future<Either<AppFailure, UserEntity>> updateProfileById({
    required String userId,
    required String firstName,
    required String lastName,
    String? middleName,
  }) async {
    return _safeCall(() async {
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

      return model.User.fromJson(response).toEntity();
    });
  }

  @override
  Stream<Either<AppFailure, UserEntity?>> authStateChanges() {
    return _client.auth.onAuthStateChange.asyncMap((event) async {
      try {
        final session = event.session;
        final supaUser = session?.user;
        if (supaUser == null) return const Right(null);

        final response = await _client
            .from('profiles')
            .select()
            .eq('id', supaUser.id)
            .maybeSingle();

        if (response == null) return const Right(null);

        return Right(model.User.fromJson(response).toEntity());
      } catch (e) {
        return Left(_handleException(e));
      }
    });
  }
}
