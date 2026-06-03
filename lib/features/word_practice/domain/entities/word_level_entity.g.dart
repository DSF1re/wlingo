// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_level_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WordLevelEntity _$WordLevelEntityFromJson(Map<String, dynamic> json) =>
    _WordLevelEntity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      levelOrder: (json['level_order'] as num).toInt(),
    );

Map<String, dynamic> _$WordLevelEntityToJson(_WordLevelEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'level_order': instance.levelOrder,
    };
