import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/data/repositories/auth_repo_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return SupabaseAuthRepository();
});
