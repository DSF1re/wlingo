import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/presentation/providers/lang_state/lang_state_provider.dart';
import 'package:wlingo/features/word_practice/domain/usecases/get_words_usecase.dart';
import 'package:wlingo/features/word_practice/domain/usecases/save_word_practice_usecase.dart';
import 'package:wlingo/main.dart';

part 'words_notifier.g.dart';

@riverpod
class WordsNotifier extends _$WordsNotifier {
  @override
  FutureOr<List<WordEntity>> build() async {
    final langId = ref.watch(langStateProvider);
    talker.info('language ID: $langId');
    return _fetchWordsFromDb(langId);
  }

  Future<List<WordEntity>> _fetchWordsFromDb(int langId) async {
    final getWords = ref.read(getWordsUseCaseProvider);
    return getWords(langId);
  }

  WordEntity? getRandomWord() {
    final words = state.value ?? [];
    if (words.isEmpty) return null;
    return words[Random().nextInt(words.length)];
  }

  Future<bool> checkAndSaveResult({
    required WordEntity word,
    required String recognizedText,
  }) async {
    final target = word.word.toLowerCase().trim();
    final recognized = recognizedText.toLowerCase().trim();
    final isCorrect =
        recognized.contains(target) || target.contains(recognized);

    await saveWordPractice(
      correctWordId: word.id,
      userAnswer: recognizedText,
      isCorrect: isCorrect,
    );

    return isCorrect;
  }

  Future<void> saveWordPractice({
    required int correctWordId,
    String? userAnswer,
    required bool isCorrect,
  }) async {
    final savePractice = ref.read(saveWordPracticeUseCaseProvider);
    await savePractice(
      correctWordId: correctWordId,
      userAnswer: userAnswer,
      isCorrect: isCorrect,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final langId = ref.read(langStateProvider);
    state = await AsyncValue.guard(() => _fetchWordsFromDb(langId));
  }
}
