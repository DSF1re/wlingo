import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const factory User({
    required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'mid_name') String? middleName,
    @JsonKey(name: 'mother_language') required int nativeLang,
    @JsonKey(name: 'isAdmin') required bool isAdmin,
    @Default(0) @JsonKey(name: 'rating', fromJson: _xpFromJson) int xp,
    @Default(0) int streak,
    @JsonKey(name: 'streak_last_date') DateTime? streakLastDate,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

int _xpFromJson(dynamic rating) {
  if (rating == null) return 0;
  if (rating is Map) return rating['points'] as int? ?? 0;
  if (rating is List && rating.isNotEmpty) return rating[0]['points'] as int? ?? 0;
  return 0;
}
