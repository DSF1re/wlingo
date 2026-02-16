import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ThemeTextStyles {
  static Color _getDefaultColor({bool? isDark}) {
    return isDark == true ? Colors.white : Colors.black;
  }

  static TextStyle title1SemiBold({
    Color? color,
    FontWeight? fontWeight = FontWeight.w600,
    bool? isDark,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color ?? _getDefaultColor(isDark: isDark),
    );
  }

  static TextStyle title3SemiBold({
    Color? color,
    FontWeight? fontWeight = FontWeight.w300,
    bool? isDark,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 17,
      fontWeight: fontWeight,
      color: color ?? _getDefaultColor(isDark: isDark),
    );
  }

  static TextStyle title1Heavy({
    Color? color,
    FontWeight? fontWeight = FontWeight.w700,
    bool? isDark,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color ?? _getDefaultColor(isDark: isDark),
    );
  }

  static TextStyle title2Heavy({
    Color? color,
    FontWeight? fontWeight = FontWeight.w800,
    bool? isDark,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color ?? _getDefaultColor(isDark: isDark),
    );
  }

  static TextStyle title1ExtraBold({
    Color? color,
    FontWeight? fontWeight = FontWeight.w800,
    bool? isDark,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color ?? _getDefaultColor(isDark: isDark),
    );
  }

  static TextStyle title2ExtraBold({
    Color? color,
    FontWeight? fontWeight = FontWeight.w800,
    bool? isDark,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color ?? _getDefaultColor(isDark: isDark),
    );
  }

  static TextStyle regular({
    Color? color,
    FontWeight? fontWeight = FontWeight.w400,
    bool? isDark,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 15,
      fontWeight: fontWeight,
      color: color ?? _getDefaultColor(isDark: isDark),
    );
  }

  static TextStyle custom({
    Color? color,
    FontWeight? fontWeight = FontWeight.w400,
    double? fontSize = 16,
    bool? isDark,
  }) {
    return GoogleFonts.finlandica(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? _getDefaultColor(isDark: isDark),
    );
  }
}
