import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/profile/data/models/rating_record/rating_record.dart';

final userHistoryProvider = FutureProvider.family<List<RatingRecord>, String>((
  ref,
  userId,
) async {
  final response = await Supabase.instance.client
      .from('ex_word_practice')
      .select()
      .eq('user_id', userId)
      .order('id', ascending: false);

  final List data = response as List;
  return data.map((json) => RatingRecord.fromJson(json)).toList();
});
