import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/models/language.dart';

class LanguageRepository {
  final SupabaseClient _client;

  LanguageRepository(this._client);

  Future<List<Language>> fetchLanguages() async {
    final response = await _client
        .from('languages')
        .select('id, name')
        .order('name');

    final list = response as List? ?? [];
    return list
        .map(
          (lang) =>
              Language(id: lang['id'] as int, name: lang['name'] as String),
        )
        .toList();
  }
}
