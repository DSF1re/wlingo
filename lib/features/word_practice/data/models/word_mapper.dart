import 'package:wlingo/features/word_practice/data/models/word.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';

extension WordMapper on Word {
  WordEntity toEntity() {
    return WordEntity(
      id: id,
      word: word,
      transcription: transcription,
      russian: russian,
      languageId: languageId,
      image: image,
    );
  }
}
