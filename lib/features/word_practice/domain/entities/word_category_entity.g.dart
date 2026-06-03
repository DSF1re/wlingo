// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WordCategoryEntity _$WordCategoryEntityFromJson(Map<String, dynamic> json) =>
    _WordCategoryEntity(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      levelId: (json['level_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WordCategoryEntityToJson(_WordCategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level_id': instance.levelId,
    };
