import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/domain/repositories/word_repository.dart';

class GetWordsUseCase {
  final WordRepository _repository;

  GetWordsUseCase(this._repository);

  Future<List<WordEntity>> call(int languageId, {int? levelId, int? maxLevelId, int? categoryId}) {
    return _repository.getWords(languageId, levelId: levelId, maxLevelId: maxLevelId, categoryId: categoryId);
  }
}
