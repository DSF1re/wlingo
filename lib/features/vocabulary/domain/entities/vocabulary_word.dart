import 'package:freezed_annotation/freezed_annotation.dart';

part 'vocabulary_word.freezed.dart';
part 'vocabulary_word.g.dart';

@freezed
sealed class VocabularyWord with _$VocabularyWord {
  const factory VocabularyWord({
    required String id,
    required String userId,
    required String word,
    required String translation,
    String? transcription,
    @Default(0) int languageId,
    DateTime? lastReviewed,
    DateTime? nextReview,
    @Default(0) int interval,
    @Default(2.5) double easeFactor,
    @Default(0) int repetitionCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _VocabularyWord;

  factory VocabularyWord.fromJson(Map<String, dynamic> json) =>
      _$VocabularyWordFromJson(json);
}
