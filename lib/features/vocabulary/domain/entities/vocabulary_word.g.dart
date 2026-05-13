// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VocabularyWord _$VocabularyWordFromJson(Map<String, dynamic> json) =>
    _VocabularyWord(
      id: json['id'] as String,
      userId: json['userId'] as String,
      word: json['word'] as String,
      translation: json['translation'] as String,
      transcription: json['transcription'] as String?,
      languageId: (json['languageId'] as num?)?.toInt() ?? 0,
      lastReviewed: json['lastReviewed'] == null
          ? null
          : DateTime.parse(json['lastReviewed'] as String),
      nextReview: json['nextReview'] == null
          ? null
          : DateTime.parse(json['nextReview'] as String),
      interval: (json['interval'] as num?)?.toInt() ?? 0,
      easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
      repetitionCount: (json['repetitionCount'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$VocabularyWordToJson(_VocabularyWord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'word': instance.word,
      'translation': instance.translation,
      'transcription': instance.transcription,
      'languageId': instance.languageId,
      'lastReviewed': instance.lastReviewed?.toIso8601String(),
      'nextReview': instance.nextReview?.toIso8601String(),
      'interval': instance.interval,
      'easeFactor': instance.easeFactor,
      'repetitionCount': instance.repetitionCount,
      'created_at': instance.createdAt?.toIso8601String(),
    };
