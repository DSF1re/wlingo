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
}
