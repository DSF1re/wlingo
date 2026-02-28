import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userRatingProvider = FutureProvider.family<int, String>((
  ref,
  userId,
) async {
  final response = await Supabase.instance.client
      .from('rating')
      .select('points')
      .eq('user_id', userId)
      .maybeSingle();

  return (response?['points'] as int?) ?? 0;
});
