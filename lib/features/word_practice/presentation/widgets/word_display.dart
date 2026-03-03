import 'package:flutter/material.dart';
import 'package:wlingo/features/home/data/models/word.dart';

class WordDisplay extends StatelessWidget {
  final Word word;
  final bool isDark;
  const WordDisplay({super.key, required this.word, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          word.word,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '[ ${word.transcription} ]',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.blueAccent.withValues(alpha: 0.5),
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          word.russian,
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.black54,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
