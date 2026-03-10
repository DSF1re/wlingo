import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/profile/data/models/rating_record/rating_record.dart';
import 'package:wlingo/features/profile/domain/providers/word_provider.dart';
import 'package:wlingo/widgets/glass_box.dart';

class HistoryTile extends ConsumerWidget {
  final RatingRecord record;
  final bool isDark;

  const HistoryTile({super.key, required this.record, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordAsync = ref.watch(wordProvider(record.correctWordId));
    final isCorrect = record.isCorrect;
    final statusColor = isCorrect
        ? const Color(0xFF2ED573)
        : const Color(0xFFFF6B6B);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassBox(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        opacity: isDark ? 0.06 : 0.25,
        blur: 8,
        borderRadius: BorderRadius.circular(16),
        color: isDark ? Colors.white : Colors.white,
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.06),
          width: 1,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isCorrect ? Icons.check_rounded : Icons.close_rounded,
                color: statusColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  wordAsync.when(
                    data: (word) => Text(
                      word.word,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    loading: () => Container(
                      height: 14,
                      width: 80,
                      decoration: BoxDecoration(
                        color: (isDark ? Colors.white : Colors.black)
                            .withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    error: (_, _) => const Text('Error'),
                  ),
                  if (record.userAnswer != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      record.userAnswer!,
                      style: TextStyle(
                        fontSize: 12,
                        color: (isDark ? Colors.white : Colors.black)
                            .withValues(alpha: 0.45),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${record.createdAt.day.toString().padLeft(2, '0')}.${record.createdAt.month.toString().padLeft(2, '0')}.${record.createdAt.year}',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: 0.3,
                ),
              ),
            ),
            const SizedBox(width: 12),
            if (!isCorrect)
              wordAsync.when(
                data: (word) => Text(
                  word.russian,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: (isDark ? Colors.white : Colors.black).withValues(
                      alpha: 0.35,
                    ),
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
          ],
        ),
      ),
    );
  }
}
