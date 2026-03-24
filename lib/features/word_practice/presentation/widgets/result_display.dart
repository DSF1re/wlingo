import 'package:flutter/material.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/widgets/glass_box.dart';

class ResultDisplay extends StatelessWidget {
  final String text;
  final bool? isCorrect;
  final String label;
  const ResultDisplay({
    super.key,
    required this.text,
    required this.isCorrect,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor = isCorrect == null
        ? (isDark ? Colors.white54 : Colors.black38)
        : (isCorrect! ? AppColors.successGreen : AppColors.errorRed);

    return GlassBox(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      opacity: isDark ? 0.06 : 0.25,
      blur: 8,
      borderRadius: BorderRadius.circular(20),
      color: isDark ? Colors.white : Colors.white,
      border: Border.all(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.06),
        width: 1,
      ),
      child: Row(
        children: [
          if (isCorrect != null)
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isCorrect! ? Icons.check_rounded : Icons.close_rounded,
                color: statusColor,
                size: 22,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: (isDark ? Colors.white : Colors.black)
                        .withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
