import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/home/data/models/word.dart';
import 'package:wlingo/features/word_practice/domain/providers/lang_state/lang_state_provider.dart';
import 'package:wlingo/main.dart';

class WordsNotifier extends AsyncNotifier<List<Word>> {
  final _client = Supabase.instance.client;

  @override
  FutureOr<List<Word>> build() async {
    final langId = ref.watch(langStateProvider);
    talker.info('language ID: $langId');
    return _fetchWordsFromDb(langId);
  }

  Future<List<Word>> _fetchWordsFromDb(int langId) async {
    final response = await _client
        .from('words')
        .select()
        .eq('language_id', langId);

    final data = response as List<dynamic>;
    return data
        .map((json) => Word.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Word? getRandomWord() {
    final words = state.value ?? [];
    if (words.isEmpty) return null;
    return words[Random().nextInt(words.length)];
  }

  Future<bool> checkAndSaveResult({
    required Word word,
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
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('ex_word_practice').insert({
      'correct_word_id': correctWordId,
      'user_answer': userAnswer,
      'user_id': user.id,
      'is_correct': isCorrect,
    });

    if (isCorrect) {
      await _addOrUpdateRating(user.id, 10);
    }
  }

  Future<void> _addOrUpdateRating(String userId, int increment) async {
    final List result = await _client
        .from('rating')
        .select('points')
        .eq('user_id', userId);

    if (result.isNotEmpty) {
      final current = (result.first['points'] ?? 0) as int;
      await _client
          .from('rating')
          .update({'points': current + increment})
          .eq('user_id', userId);
    } else {
      await _client.from('rating').insert({
        'user_id': userId,
        'points': increment,
      });
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final langId = ref.read(langStateProvider);
    state = await AsyncValue.guard(() => _fetchWordsFromDb(langId));
  }
}
