import 'package:flutter/material.dart';
import 'package:wlingo/theme/text_theme.dart';
import 'colors.dart';

ThemeData buildAppTheme({required Brightness brightness}) {
  final isLight = brightness == Brightness.light;

  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: isLight
        ? AppColors.backgroundLight
        : AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Fredoka',
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    textTheme: appTextTheme(brightness),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      fillColor: isLight ? AppColors.inputFillLight : AppColors.inputFillDark,
      filled: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(327, 56),
        textStyle: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        elevation: 2,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: isLight ? Colors.white : Color.fromARGB(255, 42, 42, 42),
      foregroundColor: isLight
          ? Colors.black
          : Color.fromARGB(255, 195, 195, 195),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: appTextTheme(brightness).labelSmall,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? AppColors.inputFillLight : AppColors.inputFillDark,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.menuBg),
      ),
    ),
    menuButtonTheme: MenuButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          Color.fromARGB(255, 220, 220, 220),
        ),
      ),
    ),
  );
}
