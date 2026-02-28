import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';
import 'package:wlingo/features/auth/domain/providers/auth_provider.dart';

final currentUserProvider = FutureProvider<Either<AuthFailure, User?>>((
  ref,
) async {
  final repository = ref.watch(authRepositoryProvider);
  return repository.getCurrentUser();
});
