import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/data/repositories/word_repo_impl.dart';
import 'package:wlingo/features/word_practice/domain/usecases/get_words_usecase.dart';
import 'package:wlingo/features/word_practice/domain/usecases/save_audition_record_usecase.dart';
import 'package:wlingo/features/word_practice/domain/usecases/save_word_practice_usecase.dart';

part 'usecase_providers.g.dart';

@riverpod
GetWordsUseCase getWordsUseCase(Ref ref) {
  return GetWordsUseCase(ref.watch(wordRepositoryProvider));
}

@riverpod
SaveWordPracticeUseCase saveWordPracticeUseCase(Ref ref) {
  return SaveWordPracticeUseCase(ref.watch(wordRepositoryProvider));
}

@riverpod
SaveAuditionRecordUseCase saveAuditionRecordUseCase(Ref ref) {
  return SaveAuditionRecordUseCase(ref.watch(wordRepositoryProvider));
}
