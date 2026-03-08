import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/word_practice/data/models/word.dart';
import 'package:wlingo/features/word_practice/data/models/word_mapper.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/domain/repositories/word_repository.dart';

part 'word_repo_impl.g.dart';

@riverpod
WordRepository wordRepository(Ref ref) {
  return SupabaseWordRepository();
}

class SupabaseWordRepository implements WordRepository {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<List<WordEntity>> getWords(int languageId) async {
    final response = await _client
        .from('words')
        .select()
        .eq('language_id', languageId);

    final data = response as List<dynamic>;

    return data
        .map((json) => Word.fromJson(json as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
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
}
