import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/domain/usecases/get_words_usecase.dart';
import 'package:wlingo/features/word_practice/domain/usecases/save_audition_record_usecase.dart';
import 'package:wlingo/features/word_practice/presentation/providers/lang_state/lang_state_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/profile/domain/providers/history_provider.dart';
import 'package:wlingo/features/profile/domain/providers/rating_provider.dart';
import 'package:wlingo/features/word_practice/presentation/providers/course_filter_notifier.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

import 'package:wlingo/features/word_practice/domain/entities/word_check_result.dart';

part 'audition_notifier.g.dart';

@Riverpod(name: 'auditionNotifierProvider')
class AuditionNotifier extends _$AuditionNotifier {
  @override
  FutureOr<List<WordEntity>> build() async {
    final langId = ref.watch(langStateProvider);
    talker.info('Audition language ID: $langId');
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
        if (maxLevelId > 4) maxLevelId = 4; // Cap at B2
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
    required String typedText,
  }) async {
    final target = word.word.toLowerCase().trim();
    final typed = typedText.toLowerCase().trim();
    final isCorrect = target == typed;

    await saveAuditionRecord(correctWordId: word.id, isCorrect: isCorrect);

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

  Future<void> saveAuditionRecord({
    required int correctWordId,
    int? selectedWordId,
    required bool isCorrect,
  }) async {
    final saveUseCase = ref.read(saveAuditionRecordUseCaseProvider);
    await saveUseCase(
      correctWordId: correctWordId,
      selectedWordId: selectedWordId,
      isCorrect: isCorrect,
    );

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      ref.invalidate(userHistoryProvider(userId));
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final langId = ref.read(langStateProvider);
    state = await AsyncValue.guard(() => _fetchWordsFromDb(langId));
  }
}
