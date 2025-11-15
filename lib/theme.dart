import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarThemeData(
    foregroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: Color.fromARGB(255, 72, 99, 210),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.w500,
    ),
  ),

  brightness: Brightness.light,

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 72, 99, 210),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      minimumSize: Size(327, 56),
      textStyle: TextStyle(
        fontFamily: 'Fredoka',
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      elevation: 2,
    ),
  ),

  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: lightText().titleSmall!.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: lightText().titleSmall!.copyWith(fontWeight: FontWeight.w500),
      filled: true,
      fillColor: const Color.fromARGB(16, 16, 16, 16),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 31, 31, 31)),
    ),
  ),

  inputDecorationTheme: InputDecorationThemeData(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    filled: true,
    fillColor: const Color.fromARGB(16, 16, 16, 16),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: lightText(),
);

TextTheme lightText() {
  return TextTheme(
    titleLarge: TextStyle(
      fontSize: 26,
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 15,
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.w400,
      color: Colors.grey[600],
      height: 1.5,
    ),
    labelLarge: TextStyle(
      fontSize: 20,
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Fredoka',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0x65687280),
    ),
  );
}

TextTheme darkTextTheme(TextTheme base) {
  return base.copyWith(
    titleLarge: base.titleLarge!.copyWith(color: Colors.white70),
    bodySmall: base.bodySmall!.copyWith(color: Colors.white60),
    bodyMedium: base.bodyMedium!.copyWith(color: Colors.white),
    labelSmall: base.labelSmall!.copyWith(color: Colors.grey[400]),
    labelLarge: base.labelLarge!.copyWith(color: Colors.white70),
    titleSmall: base.titleSmall!.copyWith(color: Colors.white54),
  );
}

ThemeData darkTheme = lightTheme.copyWith(
  inputDecorationTheme: InputDecorationThemeData(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    filled: true,
    fillColor: const Color.fromARGB(7, 241, 241, 241),
  ),

  brightness: Brightness.dark,

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color.fromARGB(255, 42, 42, 42),
    foregroundColor: const Color.fromARGB(255, 195, 195, 195),
  ),

  textTheme: darkTextTheme(lightText()),

  scaffoldBackgroundColor: Color.fromARGB(255, 27, 27, 27),

  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: darkTextTheme(
      lightText(),
    ).titleSmall!.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: darkTextTheme(
        lightText(),
      ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
      filled: true,
      fillColor: const Color.fromARGB(7, 241, 241, 241),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 31, 31, 31)),
    ),
  ),
);
