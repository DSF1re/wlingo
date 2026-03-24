import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';

import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

final currentUserProvider = StreamProvider<Either<AuthFailure, UserEntity?>>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges();
});
