import 'package:either_dart/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/vocabulary/domain/entities/vocabulary_word.dart';
import 'package:wlingo/features/vocabulary/domain/repositories/vocabulary_repository.dart';

class SupabaseVocabularyRepository implements VocabularyRepository {
  final SupabaseClient _client;

  SupabaseVocabularyRepository(this._client);

  @override
  Future<Either<AppFailure, List<VocabularyWord>>> getVocabulary() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return const Left(AppFailure.nullUser());

      final response = await _client
          .from('user_vocabulary')
          .select('*, words(*)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final List<dynamic> data = response as List<dynamic>;
      return Right(data.map((json) => _mapToEntity(json)).toList());
    } catch (e) {
      return Left(AppFailure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, List<VocabularyWord>>> getWordsForReview() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return const Left(AppFailure.nullUser());

      final response = await _client
          .from('user_vocabulary')
          .select('*, words(*)')
          .eq('user_id', userId)
          .lte('next_review', DateTime.now().toIso8601String())
          .order('next_review', ascending: true);

      final List<dynamic> data = response as List<dynamic>;
      return Right(data.map((json) => _mapToEntity(json)).toList());
    } catch (e) {
      return Left(AppFailure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> addWord({
    required String word,
    required String translation,
    String? transcription,
    required int languageId,
  }) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return const Left(AppFailure.nullUser());

      // 1. Check if word exists in general words table
      final wordResponse = await _client
          .from('words')
          .select('id')
          .eq('word', word.trim())
          .maybeSingle();

      int wordId;
      if (wordResponse == null) {
        // Create new word in global dictionary
        final newWord = await _client
            .from('words')
            .insert({
              'word': word.trim(),
              'russian': translation,
              'transcription': transcription ?? '',
              'language_id': languageId,
              'level_id': 1,
              'category_id': 6,
            })
            .select('id')
            .single();
        wordId = newWord['id'];
      } else {
        wordId = wordResponse['id'];
      }

      // 2. Add to user vocabulary
      await _client.from('user_vocabulary').upsert({
        'user_id': userId,
        'word_id': wordId,
        'translation': translation,
        'transcription': transcription ?? '',
        'language_id': languageId,
        'next_review': DateTime.now().toIso8601String(),
      });

      return const Right(null);
    } catch (e) {
      return Left(AppFailure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> updateWordAfterReview({
    required String wordId,
    required int quality,
  }) async {
    try {
      final response = await _client
          .from('user_vocabulary')
          .select('*, words(*)')
          .eq('id', wordId)
          .single();

      final current = _mapToEntity(response);
      
      // SM-2 Algorithm
      int interval;
      int repetitionCount;
      double easeFactor;

      if (quality >= 3) {
        if (current.repetitionCount == 0) {
          interval = 1;
        } else if (current.repetitionCount == 1) {
          interval = 6;
        } else {
          interval = (current.interval * current.easeFactor).round();
        }
        repetitionCount = current.repetitionCount + 1;
      } else {
        repetitionCount = 0;
        interval = 1;
      }

      easeFactor = current.easeFactor +
          (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
      if (easeFactor < 1.3) easeFactor = 1.3;

      final nextReview = DateTime.now().add(Duration(days: interval));

      await _client.from('user_vocabulary').update({
        'last_reviewed': DateTime.now().toIso8601String(),
        'next_review': nextReview.toIso8601String(),
        'interval': interval,
        'ease_factor': easeFactor,
        'repetition_count': repetitionCount,
      }).eq('id', wordId);

      return const Right(null);
    } catch (e) {
      return Left(AppFailure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteWord(String wordId) async {
    try {
      await _client.from('user_vocabulary').delete().eq('id', wordId);
      return const Right(null);
    } catch (e) {
      return Left(AppFailure.unexpected(e.toString()));
    }
  }

  VocabularyWord _mapToEntity(Map<String, dynamic> json) {
    final words = json['words'] as Map<String, dynamic>?;
    return VocabularyWord(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      word: words?['word'] ?? json['word'] ?? '',
      translation: json['translation'] ?? words?['russian'] ?? '',
      transcription: json['transcription'] ?? words?['transcription'],
      languageId: json['language_id'] ?? words?['language_id'] ?? 0,
      lastReviewed: json['last_reviewed'] != null
          ? DateTime.parse(json['last_reviewed'])
          : null,
      nextReview: json['next_review'] != null
          ? DateTime.parse(json['next_review'])
          : null,
      interval: json['interval'] ?? 0,
      easeFactor: (json['ease_factor'] as num?)?.toDouble() ?? 2.5,
      repetitionCount: json['repetition_count'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
