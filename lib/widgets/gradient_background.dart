import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const GradientBackground({
    super.key,
    required this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF010409), Color(0xFF0D1117), Color(0xFF161B22)]
              : const [Color(0xFFF7F9FC), Color(0xFFEDF2F7), Color(0xFFE2E8F0)],
        ),
      ),
      child: child,
    );
  }
}
