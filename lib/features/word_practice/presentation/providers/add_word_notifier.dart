import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/data/repositories/word_repo_impl.dart';

part 'add_word_notifier.g.dart';

@riverpod
class AddWordNotifier extends _$AddWordNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> addWord({
    required String word,
    required String transcription,
    required String russian,
    required int languageId,
    String? image,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(wordRepositoryProvider)
          .addWord(
            word: word,
            transcription: transcription,
            russian: russian,
            languageId: languageId,
          ),
    );
  }
}
