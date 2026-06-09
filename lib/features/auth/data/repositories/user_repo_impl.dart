import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart' as model;
import 'package:wlingo/features/auth/data/models/user/user_mapper.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/repositories/user_repository.dart';

class SupabaseUserRepository implements UserRepository {
  SupabaseClient get _client => Supabase.instance.client;

  AppFailure _handleException(Object e) {
    if (e is AppFailure) return e;
    if (e is SocketException ||
        e is HttpException ||
        e is HandshakeException ||
        e is TlsException) {
      return const AppFailure.networkError();
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
      talker.handle(e, st, 'SupabaseUserRepository Error');
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AppFailure, UserEntity>> updateProfile({
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
  Future<Either<AppFailure, void>> addXP({
    required String userId,
    required int amount,
  }) async {
    return _safeCall(() async {
      await _client.rpc(
        'add_user_points',
        params: {'target_user_id': userId, 'amount': amount},
      );
    });
  }

  @override
  Future<Either<AppFailure, void>> updateStreakData({
    required String userId,
    required int streak,
    required DateTime streakLastDate,
  }) async {
    return _safeCall(() async {
      await _client
          .from('profiles')
          .update({
            'streak': streak,
            'streak_last_date': streakLastDate.toIso8601String(),
          })
          .eq('id', userId);
    });
  }
}
