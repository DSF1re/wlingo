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
    required int levelId,
    required int categoryId,
    String? image,
  }) = _WordEntity;
}
