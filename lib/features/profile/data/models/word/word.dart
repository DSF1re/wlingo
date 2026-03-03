import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

@freezed
sealed class Word with _$Word {
  const factory Word({
    required int id,
    required String word,
    required String transcription,
    required String russian,
    @JsonKey(name: 'language_id') required int languageId,
  }) = _Word;
  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
