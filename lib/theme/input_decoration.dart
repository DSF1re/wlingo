import 'package:flutter/material.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';

InputDecoration formInputDecoration({
  String? label,
  required IconData icon,
  required bool isDark,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      icon,
      size: 20,
      color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
    ),
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.03),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: AppColors.primaryBlueLight.withValues(alpha: 0.5),
        width: 1.5,
      ),
    ),
    labelStyle: ThemeTextStyles.caption(
      isDark: isDark,
      color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  );
}
