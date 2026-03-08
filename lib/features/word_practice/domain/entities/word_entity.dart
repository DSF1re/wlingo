import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_entity.freezed.dart';

@freezed
sealed class WordEntity with _$WordEntity {
  const factory WordEntity({
    required int id,
    required String word,
    required String transcription,
    required String russian,
    required int languageId,
    String? image,
  }) = _WordEntity;
}
