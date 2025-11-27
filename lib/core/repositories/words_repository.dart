import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/models/word.dart';
import 'dart:math';

class WordsRepository {
  final SupabaseClient _client;
  final ValueNotifier<String> languageNotifier;

  WordsRepository(this._client, this.languageNotifier);

  // 'en' = 2, 'ru' = 1 и т.д.
  static const Map<String, int> _languageCodeToId = {
    'ru': 1,
    'en': 2,
    'de': 3,
    'fr': 4,
    'es': 5,
  };

  int _mapCodeToId(String code) {
    // по умолчанию можно вернуть 2 (English) или бросить исключение
    return _languageCodeToId[code] ?? 2;
  }

  Future<List<Word>> fetchWords() async {
    final code = languageNotifier.value;
    final languageId = _mapCodeToId(code);

    final response = await _client
        .from('words')
        .select()
        .eq('language_id', languageId);

    return (response as List).map((json) => Word.fromJson(json)).toList();
  }

  Future<Word?> fetchRandomWord() async {
    final words = await fetchWords();
    if (words.isEmpty) return null;
    final rand = Random();
    return words[rand.nextInt(words.length)];
  }

  Future<void> saveWordPractice({
    required int correctWordId,
    String? userAnswer,
    required String userId,
    required bool isCorrect,
  }) async {
    await _client.from('ex_word_practice').insert({
      'correct_word_id': correctWordId,
      'user_answer': userAnswer,
      'user_id': userId,
      'is_correct': isCorrect,
    });
  }

  Future<void> addOrUpdateRating(String userId, int increment) async {
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
}

class SupabaseIncrement {
  final int count;
  SupabaseIncrement(this.count);
  Map<String, dynamic> toJson() => {'_increment': count};
}
