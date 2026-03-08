import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';
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
      return Left(_handleException(e));
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

      return Right(User.fromJson(insertResponse));
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, User>> signIn({
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

      return Right(User.fromJson(response));
    } catch (e) {
      return Left(_handleException(e));
    }
  }

  @override
  Future<Either<AuthFailure, User>> updateProfile({
    required String firstName,
    required String lastName,
    String? middleName,
  }) async {
    try {
      final fName = firstName.trim();
      final lName = lastName.trim();
      final mName = middleName?.trim() ?? '';

      if (fName.isEmpty || lName.isEmpty) {
        return Left(AuthFailure.fillForm());
      }

      final nameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ]+$');
      final lastNameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ\s\-]+$');

      if (!nameRegExp.hasMatch(fName) ||
          !lastNameRegExp.hasMatch(lName) ||
          (mName.isNotEmpty && !nameRegExp.hasMatch(mName))) {
        return Left(AuthFailure.invalidNameFormat());
      }

      String capitalizeWord(String word) {
        if (word.isEmpty) return word;
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }

      String capitalizeComplexName(String name) {
        return name.splitMapJoin(
          RegExp(r'[ -]'),
          onMatch: (m) => m.group(0)!,
          onNonMatch: (n) => capitalizeWord(n),
        );
      }

      final formattedFirstName = capitalizeWord(fName);
      final formattedLastName = capitalizeComplexName(lName);
      final formattedMiddleName = mName.isNotEmpty
          ? capitalizeWord(mName)
          : null;

      final userId = _client.auth.currentUser?.id;
      if (userId == null) return Left(AuthFailure.nullUser());

      final response = await _client
          .from('profiles')
          .update({
            'first_name': formattedFirstName,
            'last_name': formattedLastName,
            'mid_name': formattedMiddleName,
          })
          .eq('id', userId)
          .select()
          .single();

      return Right(User.fromJson(response));
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
        return Left(_handleException(e));
      }
    });
  }
}
