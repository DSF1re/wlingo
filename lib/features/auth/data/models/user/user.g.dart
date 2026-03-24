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
  'created_at': instance.createdAt?.toIso8601String(),
};
