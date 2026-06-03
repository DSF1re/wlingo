import 'package:wlingo/features/auth/domain/entities/streak_update_result.dart';

class WordCheckResult {
  final bool isCorrect;
  final StreakUpdateResult? streakResult;

  const WordCheckResult({
    required this.isCorrect,
    this.streakResult,
  });
}
