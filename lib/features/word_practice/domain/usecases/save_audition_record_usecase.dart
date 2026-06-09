import 'package:wlingo/features/word_practice/domain/repositories/word_repository.dart';

class SaveAuditionRecordUseCase {
  final WordRepository _repository;

  SaveAuditionRecordUseCase(this._repository);

  Future<void> call({
    required int correctWordId,
    int? selectedWordId,
    required bool isCorrect,
  }) {
    return _repository.saveAuditionRecord(
      correctWordId: correctWordId,
      selectedWordId: selectedWordId,
      isCorrect: isCorrect,
    );
  }
}
