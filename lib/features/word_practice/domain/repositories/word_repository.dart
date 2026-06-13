import 'package:wlingo/features/word_practice/domain/entities/word_category_entity.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_level_entity.dart';

abstract class WordRepository {
  Future<List<WordEntity>> getWords(int languageId, {int? levelId, int? maxLevelId, int? categoryId});
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
    int? levelId,
    int? categoryId,
  });
  Future<List<WordLevelEntity>> getLevels();
  Future<List<WordCategoryEntity>> getCategories();
}
