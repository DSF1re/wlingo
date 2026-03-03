import 'package:flutter/material.dart';

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
    final color = isCorrect == null
        ? null
        : (isCorrect! ? Colors.green : Colors.red);
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
