import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/bookview/data/models/book.dart';
import 'package:wlingo/features/bookview/data/models/book_mapper.dart';
import 'package:wlingo/features/bookview/domain/entities/book_entity.dart';
import 'package:wlingo/features/bookview/domain/repositories/book_repository.dart';

class SupabaseBookRepository implements BookRepository {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<List<BookEntity>> getBooks(int languageId) async {
    try {
      final response = await _client
          .from('books')
          .select()
          .eq('language_id', languageId);

      final data = response as List<dynamic>;

      return data
          .map((json) => Book.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addBook({
    required String title,
    required String author,
    required String localFilePath,
    required String fileName,
    required int languageId,
  }) async {
    try {
      final file = File(localFilePath);
      final fileExt = fileName.contains('.') ? fileName.split('.').last : 'pdf';
      final newFileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      await _client.storage.from('books').upload(newFileName, file);

      final publicUrl = _client.storage.from('books').getPublicUrl(newFileName);

      await _client.from('books').insert({
        'title': title,
        'author': author,
        'file_path': publicUrl,
        'language_id': languageId,
      });
    } catch (e) {
      rethrow;
    }
  }
}
