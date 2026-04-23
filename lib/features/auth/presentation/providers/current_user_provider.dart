import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';

import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

final currentUserProvider = StreamProvider<Either<AppFailure, UserEntity?>>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges();
});
