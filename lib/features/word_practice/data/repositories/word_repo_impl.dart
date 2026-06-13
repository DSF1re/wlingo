import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/word_practice/data/models/word.dart';
import 'package:wlingo/features/word_practice/data/models/word_mapper.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_category_entity.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_level_entity.dart';
import 'package:wlingo/features/word_practice/domain/repositories/word_repository.dart';

part 'word_repo_impl.g.dart';

@riverpod
WordRepository wordRepository(Ref ref) {
  return SupabaseWordRepository();
}

final wordLevelsProvider = FutureProvider<List<WordLevelEntity>>((ref) async {
  return ref.read(wordRepositoryProvider).getLevels();
});

final wordCategoriesProvider = FutureProvider<List<WordCategoryEntity>>((ref) async {
  return ref.read(wordRepositoryProvider).getCategories();
});

class SupabaseWordRepository implements WordRepository {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<List<WordEntity>> getWords(int languageId, {int? levelId, int? maxLevelId, int? categoryId}) async {
    var query = _client
        .from('words')
        .select()
        .eq('language_id', languageId);

    if (levelId != null) {
      query = query.eq('level_id', levelId);
    } else if (maxLevelId != null) {
      query = query.lte('level_id', maxLevelId);
    }
    if (categoryId != null) {
      query = query.eq('category_id', categoryId);
    }

    final response = await query;
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

  @override
  Future<void> saveAuditionRecord({
    required int correctWordId,
    int? selectedWordId,
    required bool isCorrect,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('ex_audition').insert({
      'correct_word_id': correctWordId,
      'selected_word_id': selectedWordId,
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

  @override
  Future<void> addWord({
    required String word,
    required String transcription,
    required String russian,
    required int languageId,
    int? levelId,
    int? categoryId,
  }) async {
    await _client.from('words').insert({
      'word': word,
      'transcription': transcription,
      'russian': russian,
      'language_id': languageId,
      'level_id': levelId ?? 1,
      'category_id': categoryId ?? 6,
    });
  }

  @override
  Future<List<WordLevelEntity>> getLevels() async {
    final response = await _client.from('word_levels').select().order('level_order');
    final data = response as List<dynamic>;
    return data.map((json) => WordLevelEntity.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<WordCategoryEntity>> getCategories() async {
    final response = await _client.from('word_categories').select().order('name');
    final data = response as List<dynamic>;
    return data.map((json) => WordCategoryEntity.fromJson(json as Map<String, dynamic>)).toList();
  }
}
