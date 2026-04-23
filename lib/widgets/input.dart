import 'package:flutter/material.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';

class Input extends StatelessWidget {
  final TextStyle? style;
  final String? labelText;
  final double borderRadius;
  final TextEditingController? controller;
  final String? hint;
  final double height;
  final double width;
  final bool isObscured;
  final Widget? suffixIcon;
  const Input({
    super.key,
    this.style,
    this.labelText,
    this.hint,
    this.borderRadius = 10,
    this.controller,
    this.height = 50,
    this.width = double.infinity,
    this.isObscured = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark
        ? true
        : false;
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: isDark ? AppColors.inputLight : AppColors.inputDark,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        obscureText: isObscured,
        style: style ?? ThemeTextStyles.regular(isDark: isDark),
        decoration: InputDecoration(
          filled: true,
          fillColor: isDark ? AppColors.inputDark : AppColors.inputLight,
          hintText: hint,
          labelText: labelText,
          hintStyle: ThemeTextStyles.regular(isDark: isDark),
          suffixIcon: suffixIcon,
          border: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
        ),
      ),
    );
  }
}
