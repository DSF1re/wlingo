import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/usecases/get_current_user_usecase.dart';

final currentUserProvider = FutureProvider<Either<AuthFailure, UserEntity?>>((
  ref,
) async {
  final getCurrentUser = ref.watch(getCurrentUserUseCaseProvider);
  return getCurrentUser();
});
