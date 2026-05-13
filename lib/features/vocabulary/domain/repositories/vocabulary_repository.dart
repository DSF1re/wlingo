import 'package:either_dart/either.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/vocabulary/domain/entities/vocabulary_word.dart';

abstract class VocabularyRepository {
  Future<Either<AppFailure, List<VocabularyWord>>> getVocabulary();
  Future<Either<AppFailure, List<VocabularyWord>>> getWordsForReview();
  Future<Either<AppFailure, void>> addWord({
    required String word,
    required String translation,
    String? transcription,
    required int languageId,
  });
  Future<Either<AppFailure, void>> updateWordAfterReview({
    required String wordId,
    required int quality, // 0-5
  });
  Future<Either<AppFailure, void>> deleteWord(String wordId);
}
