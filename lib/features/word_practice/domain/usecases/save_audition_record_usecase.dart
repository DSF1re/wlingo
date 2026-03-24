import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/domain/repositories/word_repository.dart';
import 'package:wlingo/features/word_practice/data/repositories/word_repo_impl.dart';

part 'save_audition_record_usecase.g.dart';

@riverpod
SaveAuditionRecordUseCase saveAuditionRecordUseCase(Ref ref) {
  return SaveAuditionRecordUseCase(ref.watch(wordRepositoryProvider));
}

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
