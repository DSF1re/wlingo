// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  middleName: json['mid_name'] as String?,
  nativeLang: (json['mother_language'] as num).toInt(),
  isAdmin: json['isAdmin'] as bool,
  xp: json['rating'] == null ? 0 : _xpFromJson(json['rating']),
  streak: (json['streak'] as num?)?.toInt() ?? 0,
  streakLastDate: json['streak_last_date'] == null
      ? null
      : DateTime.parse(json['streak_last_date'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'mid_name': instance.middleName,
  'mother_language': instance.nativeLang,
  'isAdmin': instance.isAdmin,
  'rating': instance.xp,
  'streak': instance.streak,
  'streak_last_date': instance.streakLastDate?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
};
