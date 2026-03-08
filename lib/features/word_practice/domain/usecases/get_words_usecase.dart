import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/domain/repositories/word_repository.dart';
import 'package:wlingo/features/word_practice/data/repositories/word_repo_impl.dart';

part 'get_words_usecase.g.dart';

@riverpod
GetWordsUseCase getWordsUseCase(Ref ref) {
  return GetWordsUseCase(ref.watch(wordRepositoryProvider));
}

class GetWordsUseCase {
  final WordRepository _repository;

  GetWordsUseCase(this._repository);

  Future<List<WordEntity>> call(int languageId) {
    return _repository.getWords(languageId);
  }
}
