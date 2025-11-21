import 'package:flutter/material.dart';

TextTheme appTextTheme(Brightness brightness) {
  final base = TextTheme(
    titleLarge: TextStyle(
      fontSize: 26,
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.w500,
      color: brightness == Brightness.light ? Colors.black87 : Colors.white70,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: brightness == Brightness.light ? Colors.black : Colors.white60,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: brightness == Brightness.light ? Colors.black : Colors.white60,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: brightness == Brightness.light ? Colors.white : Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 15,
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.w400,
      color: brightness == Brightness.light
          ? Colors.grey[600]
          : Colors.grey[400],
      height: 1.5,
    ),
    labelLarge: TextStyle(
      fontSize: 20,
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.w500,
      color: brightness == Brightness.light ? Colors.black87 : Colors.white70,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: brightness == Brightness.light
          ? Color(0x65687280)
          : Colors.white70,
    ),
  );
  return base;
}
