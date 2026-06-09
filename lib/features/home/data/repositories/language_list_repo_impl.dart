import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/home/data/models/language.dart';
import 'package:wlingo/features/home/domain/language_list_repository.dart';

class SupabaseLanguageListRepository implements LanguageListRepository {
  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<List<Language>> getList() async {
    final response = await _client.from('languages').select('*');
    return (response as List).map((json) => Language.fromJson(json)).toList();
  }
}
