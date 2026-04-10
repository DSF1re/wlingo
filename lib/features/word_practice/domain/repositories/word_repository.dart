import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';

abstract class WordRepository {
  Future<List<WordEntity>> getWords(int languageId);
  Future<void> saveWordPractice({
    required int correctWordId,
    String? userAnswer,
    required bool isCorrect,
  });
  Future<void> saveAuditionRecord({
    required int correctWordId,
    int? selectedWordId,
    required bool isCorrect,
  });
  Future<void> addWord({
    required String word,
    required String transcription,
    required String russian,
    required int languageId,
  });
}
