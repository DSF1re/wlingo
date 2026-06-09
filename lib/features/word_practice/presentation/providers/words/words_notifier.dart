import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/presentation/providers/lang_state/lang_state_provider.dart';
import 'package:wlingo/features/word_practice/domain/services/word_match_service.dart';
import 'package:wlingo/features/word_practice/presentation/providers/usecase_providers.dart';
import 'package:wlingo/features/word_practice/presentation/providers/course_filter_notifier.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/features/auth/presentation/providers/usecase_providers.dart';

import 'package:wlingo/features/word_practice/domain/entities/word_check_result.dart';

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
    final filter = ref.read(courseFilterProvider);
    
    int? maxLevelId;
    if (filter.levelId == null) {
      final getCurrentUser = ref.read(getCurrentUserUseCaseProvider);
      final userResult = await getCurrentUser();
      final user = userResult.fold((l) => null, (r) => r);
      if (user != null) {
        maxLevelId = (user.xp ~/ 200) + 1;
        if (maxLevelId > 4) maxLevelId = 4;
      }
    }

    return getWords(
      langId,
      levelId: filter.levelId,
      maxLevelId: maxLevelId,
      categoryId: filter.categoryId,
    );
  }

  WordEntity? getRandomWord() {
    final words = state.value ?? [];
    if (words.isEmpty) return null;
    return words[Random().nextInt(words.length)];
  }

  final _wordMatch = WordMatchService();

  Future<WordCheckResult> checkAndSaveResult({
    required WordEntity word,
    required String recognizedText,
  }) async {
    final isCorrect = _wordMatch.isPronunciationMatch(
      word.word,
      recognizedText,
    );

    await saveWordPractice(
      correctWordId: word.id,
      userAnswer: recognizedText,
      isCorrect: isCorrect,
    );

    if (isCorrect) {
      await ref.read(addXPUseCaseProvider)(15);
      final updateResult = await ref.read(updateStreakUseCaseProvider)();
      final streakRes = updateResult.fold(
        (l) => null,
        (r) => r,
      );
      return WordCheckResult(isCorrect: true, streakResult: streakRes);
    }

    return const WordCheckResult(isCorrect: false);
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
