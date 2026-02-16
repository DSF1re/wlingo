import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ThemeTextStyles {
  static TextStyle title1SemiBold({
    Color? color = Colors.black,
    FontWeight? fontWeight = FontWeight.w600,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle title3SemiBold({
    Color? color = Colors.black,
    FontWeight? fontWeight = FontWeight.w300,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 17,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle title1Heavy({
    Color? color = Colors.black,
    FontWeight? fontWeight = FontWeight.w700,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle title2Heavy({
    Color? color = Colors.black,
    FontWeight? fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle title1ExtraBold({
    Color? color = Colors.black,
    FontWeight? fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 24,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle title2ExtraBold({
    Color? color = Colors.black,
    FontWeight? fontWeight = FontWeight.w800,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 20,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle regular({
    Color? color = Colors.black,
    FontWeight? fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.finlandica(
      fontSize: 15,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle custom({
    Color? color = Colors.black,
    FontWeight? fontWeight = FontWeight.w400,
    double? fontSize = 16,
  }) {
    return GoogleFonts.finlandica(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
