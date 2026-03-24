import 'package:flutter/material.dart';
import 'package:wlingo/theme/app_colors.dart';

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
              ? const [AppColors.darkBgDarker, AppColors.darkBg, AppColors.darkBgLighter]
              : const [AppColors.lightBgLighter, AppColors.lightBg, AppColors.lightBgDarker],
        ),
      ),
      child: child,
    );
  }
}
