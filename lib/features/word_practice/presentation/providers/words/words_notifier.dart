import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/presentation/providers/lang_state/lang_state_provider.dart';
import 'package:wlingo/features/word_practice/domain/usecases/get_words_usecase.dart';
import 'package:wlingo/features/word_practice/domain/usecases/save_word_practice_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/profile/domain/providers/rating_provider.dart';
import 'package:wlingo/features/word_practice/presentation/providers/course_filter_notifier.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

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
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null) {
        final xp = await ref.read(userRatingProvider(userId).future);
        maxLevelId = (xp ~/ 200) + 1;
        if (maxLevelId > 4) maxLevelId = 4; // Cap at B2 (level 4)
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

  Future<WordCheckResult> checkAndSaveResult({
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

    if (isCorrect) {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.addXP(15);
      final updateResult = await authRepo.updateStreak();
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
