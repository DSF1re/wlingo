import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/auth/domain/usecases/add_xp_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/get_all_users_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/get_users_with_ratings_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/update_streak_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/update_user_admin_usecase.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

part 'usecase_providers.g.dart';

@riverpod
SignInUseCase signInUseCase(Ref ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(Ref ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
GetAllUsersUseCase getAllUsersUseCase(Ref ref) {
  return GetAllUsersUseCase(ref.watch(userRepositoryProvider));
}

@riverpod
GetUsersWithRatingsUseCase getUsersWithRatingsUseCase(Ref ref) {
  return GetUsersWithRatingsUseCase(ref.watch(userRepositoryProvider));
}

@riverpod
UpdateProfileUseCase updateProfileUseCase(Ref ref) {
  return UpdateProfileUseCase(ref.watch(userRepositoryProvider));
}

@riverpod
UpdateUserAdminUseCase updateUserAdminUseCase(Ref ref) {
  return UpdateUserAdminUseCase(ref.watch(userRepositoryProvider));
}

@riverpod
AddXPUseCase addXPUseCase(Ref ref) {
  return AddXPUseCase(
    ref.watch(authRepositoryProvider),
    ref.watch(userRepositoryProvider),
  );
}

@riverpod
UpdateStreakUseCase updateStreakUseCase(Ref ref) {
  return UpdateStreakUseCase(
    ref.watch(authRepositoryProvider),
    ref.watch(userRepositoryProvider),
  );
}
