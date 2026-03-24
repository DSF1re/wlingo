import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/profile/data/models/rating_record/rating_record.dart';
import 'package:wlingo/features/profile/domain/providers/word_provider.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';
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
        ? AppColors.successGreen
        : AppColors.errorRed;

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
                      style: ThemeTextStyles.regular(
                        fontWeight: FontWeight.w600,
                        isDark: isDark,
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
                      style: ThemeTextStyles.caption(
                        isDark: isDark,
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
              style: ThemeTextStyles.small(
                isDark: isDark,
                color: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
