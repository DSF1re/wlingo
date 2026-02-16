import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wlingo/theme/colors.dart';
import 'package:wlingo/theme/text_styles.dart';

class Button extends StatelessWidget {
  final String text;
  final double height;
  final FutureOr<void> Function()? onClicked;
  final Color color;
  const Button({
    super.key,
    required this.text,
    this.onClicked,
    this.height = 40,
    this.color = ThemeColors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: ThemeTextStyles.title3SemiBold(color: Colors.white),
        ),
      ),
    );
  }
}
