import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wlingo/theme/colors.dart';
import 'package:wlingo/theme/text_styles.dart';

class Button extends StatelessWidget {
  final String text;
  final double height;
  final FutureOr<void> Function()? onClicked;
  final Color color;
  final bool isLoading;
  const Button({
    super.key,
    required this.text,
    this.onClicked,
    this.height = 50,
    this.color = ThemeColors.blue,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark
    //     ? true
    //     : false;
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
        child: Padding(
          padding: EdgeInsets.all(8),
          child: !isLoading
              ? Text(
                  text,
                  style: ThemeTextStyles.custom(
                    isDark: true,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
