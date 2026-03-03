// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatingRecord _$RatingRecordFromJson(Map<String, dynamic> json) =>
    _RatingRecord(
      id: (json['id'] as num).toInt(),
      correctWordId: (json['correct_word_id'] as num).toInt(),
      userAnswer: json['user_answer'] as String?,
      userId: json['user_id'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$RatingRecordToJson(_RatingRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'correct_word_id': instance.correctWordId,
      'user_answer': instance.userAnswer,
      'user_id': instance.userId,
      'is_correct': instance.isCorrect,
    };
