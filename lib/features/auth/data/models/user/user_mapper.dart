import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';

extension UserModelX on User {
  UserEntity toEntity() {
    int displayStreak = streak;
    if (streakLastDate != null) {
      final now = DateTime.now().toUtc();
      final today = DateTime.utc(now.year, now.month, now.day);
      final lastDate = streakLastDate!.toUtc();
      final lastDay = DateTime.utc(lastDate.year, lastDate.month, lastDate.day);
      
      if (today.difference(lastDay).inDays > 1) {
        displayStreak = 0;
      }
    }

    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      nativeLang: nativeLang,
      isAdmin: isAdmin,
      xp: xp,
      streak: displayStreak,
      streakLastDate: streakLastDate,
      createdAt: createdAt,
    );
  }
}
