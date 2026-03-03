import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_record.freezed.dart';
part 'rating_record.g.dart';

@freezed
sealed class RatingRecord with _$RatingRecord {
  const factory RatingRecord({
    required int id,
    @JsonKey(name: 'correct_word_id') required int correctWordId,
    @JsonKey(name: 'user_answer') required String? userAnswer,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'is_correct') required bool isCorrect,
  }) = _RatingRecord;
  factory RatingRecord.fromJson(Map<String, dynamic> json) =>
      _$RatingRecordFromJson(json);
}
