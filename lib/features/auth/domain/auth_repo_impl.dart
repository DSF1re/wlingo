import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:wlingo/core/public_vars.dart';
import 'package:wlingo/features/auth/data/auth_repository.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<User?> getCurrentUser() async {
    final session = _client.auth.currentSession;
    final supaUser = session?.user;
    if (supaUser == null) return null;

    final response = await _client
        .from('users')
        .select()
        .eq('id', supaUser.id)
        .maybeSingle();

    if (response == null) return null;

    return User.fromJson(response);
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String middleName,
    required int nativeLang,
  }) async {
    final authResponse = await _client.auth.signUp(
      email: email,
      password: password,
    );

    final supaUser = authResponse.user;
    if (supaUser == null) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Registration failed')),
      );
      throw Exception('Registration failed');
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

    return User.fromJson(insertResponse);
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    final authResponse = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final supaUser = authResponse.user;
    if (supaUser == null) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Login failed')),
      );
      throw Exception('Login failed');
    }

    final response = await _client
        .from('profiles')
        .select()
        .eq('id', supaUser.id)
        .single();

    return User.fromJson(response);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Stream<User?> authStateChanges() {
    return _client.auth.onAuthStateChange.asyncMap((event) async {
      final session = event.session;
      final supaUser = session?.user;
      if (supaUser == null) return null;

      final response = await _client
          .from('profiles')
          .select()
          .eq('id', supaUser.id)
          .maybeSingle();

      if (response == null) return null;

      return User.fromJson(response);
    });
  }
}
