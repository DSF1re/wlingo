import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/profile/data/models/rating_record/rating_record.dart';

final userHistoryProvider = FutureProvider.family<List<RatingRecord>, String>((
  ref,
  userId,
) async {
  final client = Supabase.instance.client;

  final practiceFuture = client
      .from('ex_word_practice')
      .select()
      .eq('user_id', userId)
      .order('created_at', ascending: false)
      .limit(50);

  final auditionFuture = client
      .from('ex_audition')
      .select()
      .eq('user_id', userId)
      .order('created_at', ascending: false)
      .limit(50);

  final responses = await Future.wait([practiceFuture, auditionFuture]);

  final List practiceData = responses[0] as List;
  final List auditionData = responses[1] as List;

  final practiceRecords = practiceData.map(
    (json) => RatingRecord.fromJson(json),
  );

  final auditionRecords = auditionData.map((json) {
    return RatingRecord(
      id: json['id'],
      correctWordId: json['correct_word_id'],
      userAnswer: null,
      userId: json['user_id'],
      isCorrect: json['is_correct'],
      createdAt: DateTime.parse(json['created_at']),
    );
  });

  final combined = [...practiceRecords, ...auditionRecords]
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  return combined;
});
