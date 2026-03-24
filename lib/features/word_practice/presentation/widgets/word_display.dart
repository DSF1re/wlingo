import 'package:flutter/material.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/theme/app_colors.dart';

class WordDisplay extends StatelessWidget {
  final WordEntity word;
  final bool isDark;
  const WordDisplay({super.key, required this.word, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Text(
            word.word,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: AppColors.successGreen,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '[ ${word.transcription} ]',
            style: TextStyle(
              fontFamily: 'monospace',
              color: AppColors.primaryBlue.withValues(alpha: 0.6),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            word.russian,
            style: TextStyle(
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.5,
              ),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
