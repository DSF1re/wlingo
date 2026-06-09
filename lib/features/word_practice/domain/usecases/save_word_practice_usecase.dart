import 'package:wlingo/features/word_practice/domain/repositories/word_repository.dart';

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
