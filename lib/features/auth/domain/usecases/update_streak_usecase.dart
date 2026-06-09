import 'package:either_dart/either.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/entities/streak_update_result.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/domain/repositories/user_repository.dart';

class UpdateStreakUseCase {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  UpdateStreakUseCase(this._authRepository, this._userRepository);

  Future<Either<AppFailure, StreakUpdateResult?>> call() async {
    final userResult = await _authRepository.getCurrentUser();
    return userResult.fold(
      (failure) => Left(failure),
      (user) async {
        if (user == null) {
          return const Left(AppFailure.nullUser());
        }

        final now = DateTime.now().toUtc();
        final today = DateTime.utc(now.year, now.month, now.day);
        final lastDate = user.streakLastDate;
        final currentStreak = user.streak;

        if (lastDate != null) {
          final lastDay = DateTime.utc(lastDate.year, lastDate.month, lastDate.day);

          if (today.isAtSameMomentAs(lastDay)) {
            return const Right(null);
          }

          final diffDays = today.difference(lastDay).inDays;

          if (diffDays == 1) {
            final nextStreak = currentStreak + 1;
            final updateRes = await _userRepository.updateStreakData(
              userId: user.id,
              streak: nextStreak,
              streakLastDate: today,
            );
            return updateRes.fold(
              (failure) => Left(failure),
              (_) => Right(StreakUpdateResult(
                didUpdate: true,
                oldStreak: currentStreak,
                newStreak: nextStreak,
                isReset: false,
              )),
            );
          } else {
            final nextStreak = 1;
            final updateRes = await _userRepository.updateStreakData(
              userId: user.id,
              streak: nextStreak,
              streakLastDate: today,
            );
            return updateRes.fold(
              (failure) => Left(failure),
              (_) => Right(StreakUpdateResult(
                didUpdate: true,
                oldStreak: currentStreak,
                newStreak: nextStreak,
                isReset: true,
              )),
            );
          }
        } else {
          final nextStreak = 1;
          final updateRes = await _userRepository.updateStreakData(
            userId: user.id,
            streak: nextStreak,
            streakLastDate: today,
          );
          return updateRes.fold(
            (failure) => Left(failure),
            (_) => Right(StreakUpdateResult(
              didUpdate: true,
              oldStreak: 0,
              newStreak: nextStreak,
              isReset: false,
            )),
          );
        }
      },
    );
  }
}
