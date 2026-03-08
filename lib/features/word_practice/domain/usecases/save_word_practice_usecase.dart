import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/domain/repositories/word_repository.dart';
import 'package:wlingo/features/word_practice/data/repositories/word_repo_impl.dart';

part 'save_word_practice_usecase.g.dart';

@riverpod
SaveWordPracticeUseCase saveWordPracticeUseCase(Ref ref) {
  return SaveWordPracticeUseCase(ref.watch(wordRepositoryProvider));
}

class SaveWordPracticeUseCase {
  final WordRepository _repository;

  SaveWordPracticeUseCase(this._repository);

  Future<void> call({
    required int correctWordId,
    String? userAnswer,
    required bool isCorrect,
  }) {
    return _repository.saveWordPractice(
      correctWordId: correctWordId,
      userAnswer: userAnswer,
      isCorrect: isCorrect,
    );
  }
}
