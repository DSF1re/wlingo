import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/models/word.dart';
import 'dart:math';

class WordsRepository {
  final SupabaseClient _client;

  WordsRepository(this._client);

  Future<List<Word>> fetchWords() async {
    final response = await _client.from('words').select();

    return (response as List).map((json) => Word.fromJson(json)).toList();
  }

  Future<Word> fetchRandomWord() async {
    final words = await fetchWords();
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
