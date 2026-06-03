// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Word _$WordFromJson(Map<String, dynamic> json) => _Word(
  id: (json['id'] as num).toInt(),
  word: json['word'] as String,
  transcription: json['transcription'] as String,
  russian: json['russian'] as String,
  languageId: (json['language_id'] as num).toInt(),
  levelId: (json['level_id'] as num).toInt(),
  categoryId: (json['category_id'] as num).toInt(),
);

Map<String, dynamic> _$WordToJson(_Word instance) => <String, dynamic>{
  'id': instance.id,
  'word': instance.word,
  'transcription': instance.transcription,
  'russian': instance.russian,
  'language_id': instance.languageId,
  'level_id': instance.levelId,
  'category_id': instance.categoryId,
};
