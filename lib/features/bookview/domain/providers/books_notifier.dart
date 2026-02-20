import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/bookview/data/models/book.dart';
import 'package:wlingo/main.dart';

class BooksNotifier extends AsyncNotifier<List<Book>> {
  @override
  FutureOr<List<Book>> build() async {
    return _fetchFromSupabase();
  }

  Future<List<Book>> _fetchFromSupabase() async {
    final client = Supabase.instance.client;

    final langId = shared.getInt('lang_cource') ?? 2;
    try {
      final response = await client
          .from('books')
          .select()
          .eq('language_id', langId);

      final data = response as List<dynamic>;

      return data
          .map((json) => Book.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchFromSupabase());
  }
}
