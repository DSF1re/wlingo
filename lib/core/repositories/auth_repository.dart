import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _client;

  AuthRepository(this._client);

  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<User> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int motherLanguageId,
  }) async {
    final signUpResponse = await _client.auth.signUp(
      email: email.trim(),
      password: password,
    );

    final user = signUpResponse.user;
    if (user == null) throw Exception('Registration failed');

    await _client.from('profiles').insert({
      'id': user.id,
      'first_name': firstName.trim(),
      'last_name': lastName.trim(),
      'mother_language': motherLanguageId,
    });

    return user;
  }
}
