import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/features/auth/data/auth_repository.dart';
import 'package:wlingo/features/auth/domain/auth_repo_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return SupabaseAuthRepository();
});
