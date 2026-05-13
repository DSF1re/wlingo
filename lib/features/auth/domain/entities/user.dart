import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String firstName,
    required String lastName,
    String? middleName,
    required int nativeLang,
    required bool isAdmin,
    @Default(0) int xp,
    @Default(0) int streak,
    DateTime? streakLastDate,
    DateTime? createdAt,
  }) = _UserEntity;
}
