import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/models/books.dart';

class BooksRepository {
  final SupabaseClient _client;
  final ValueNotifier<String> languageNotifier; // 'en','ru','de','fr','es'

  BooksRepository(this._client, this.languageNotifier);

  static const _langCodeToId = {'ru': 1, 'en': 2, 'de': 3, 'fr': 4, 'es': 5};

  int _langId() => _langCodeToId[languageNotifier.value] ?? 2;

  Future<List<Book>> fetchBooks() async {
    final response = await _client
        .from('books')
        .select()
        .eq('language_id', _langId());

    return (response as List)
        .map((json) => Book.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
