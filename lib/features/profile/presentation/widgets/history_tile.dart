import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/profile/data/models/rating_record/rating_record.dart';
import 'package:wlingo/features/profile/domain/providers/word_provider.dart';

class HistoryTile extends ConsumerWidget {
  final RatingRecord record;
  final bool isDark;

  const HistoryTile({super.key, required this.record, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordAsync = ref.watch(wordProvider(record.correctWordId));

    return ListTile(
      leading: Icon(
        record.isCorrect ? Icons.check_circle : Icons.cancel,
        color: record.isCorrect ? Colors.green : Colors.red,
      ),
      title: wordAsync.when(
        data: (word) => Text(word.word),
        loading: () => const Text(''),
        error: (_, _) => const Text('Error'),
      ),
      subtitle: Text(record.userAnswer ?? 'No answer'),
      trailing: record.isCorrect
          ? null
          : wordAsync.when(
              data: (word) =>
                  Text(word.russian, style: TextStyle(color: Colors.grey)),
              loading: () => null,
              error: (_, _) => null,
            ),
    );
  }
}
