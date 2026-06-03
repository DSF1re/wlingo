class StreakUpdateResult {
  final bool didUpdate;
  final int oldStreak;
  final int newStreak;
  final bool isReset;

  const StreakUpdateResult({
    required this.didUpdate,
    required this.oldStreak,
    required this.newStreak,
    required this.isReset,
  });
}
