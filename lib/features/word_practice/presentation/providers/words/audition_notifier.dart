import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/domain/usecases/get_words_usecase.dart';
import 'package:wlingo/features/word_practice/domain/usecases/save_audition_record_usecase.dart';
import 'package:wlingo/features/word_practice/presentation/providers/lang_state/lang_state_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/profile/domain/providers/history_provider.dart';
import 'package:wlingo/core/global_variables/services.dart';

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
    return getWords(langId);
  }

  WordEntity? getRandomWord() {
    final words = state.value ?? [];
    if (words.isEmpty) return null;
    return words[Random().nextInt(words.length)];
  }

  Future<bool> checkAndSaveResult({
    required WordEntity word,
    required String typedText,
  }) async {
    final target = word.word.toLowerCase().trim();
    final typed = typedText.toLowerCase().trim();
    final isCorrect = target == typed;

    await saveAuditionRecord(correctWordId: word.id, isCorrect: isCorrect);

    return isCorrect;
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
