import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/vocabulary/data/repositories/vocabulary_repo_impl.dart';
import 'package:wlingo/features/vocabulary/domain/entities/vocabulary_word.dart';
import 'package:wlingo/features/vocabulary/domain/repositories/vocabulary_repository.dart';

final vocabularyRepositoryProvider = Provider<VocabularyRepository>((ref) {
  return SupabaseVocabularyRepository(Supabase.instance.client);
});

final vocabularyListProvider =
    AsyncNotifierProvider<VocabularyNotifier, List<VocabularyWord>>(() {
  return VocabularyNotifier();
});

class VocabularyNotifier extends AsyncNotifier<List<VocabularyWord>> {
  @override
  Future<List<VocabularyWord>> build() async {
    final repo = ref.watch(vocabularyRepositoryProvider);
    final result = await repo.getVocabulary();
    return result.fold(
      (failure) => throw failure,
      (list) => list,
    );
  }

  Future<void> addWord({
    required String word,
    required String translation,
    String? transcription,
    required int languageId,
    int? levelId,
    int? categoryId,
  }) async {
    state = const AsyncValue.loading();
    final repo = ref.read(vocabularyRepositoryProvider);
    final result = await repo.addWord(
      word: word,
      translation: translation,
      transcription: transcription,
      languageId: languageId,
      levelId: levelId,
      categoryId: categoryId,
    );

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> deleteWord(String wordId) async {
    final repo = ref.read(vocabularyRepositoryProvider);
    final result = await repo.deleteWord(wordId);
    
    if (result.isRight) {
      ref.invalidateSelf();
    }
  }
}

final reviewWordsProvider = FutureProvider<List<VocabularyWord>>((ref) async {
  final repo = ref.watch(vocabularyRepositoryProvider);
  final result = await repo.getWordsForReview();
  return result.fold(
    (failure) => throw failure,
    (list) => list,
  );
});
