import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/home/data/models/word.dart';

final wordProvider = FutureProvider.family<Word, int>((ref, wordId) async {
  final response = await Supabase.instance.client
      .from('words')
      .select()
      .eq('id', wordId)
      .single();
  return Word.fromJson(response);
});
