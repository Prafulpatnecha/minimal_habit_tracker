import 'package:flutter/material.dart';

class ThemeEdit {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black12
    ),
      checkboxTheme: CheckboxThemeData(checkColor: WidgetStateProperty.all(Colors.black)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.white),
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.green,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white.withOpacity(0.9),
          onSurface: Colors.black));
  static ThemeData darkTheme = ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.black12,
        // actionsIconTheme: IconThemeData(color: Colors.black)
      ),
      checkboxTheme: CheckboxThemeData(checkColor: WidgetStateProperty.all(Colors.black),fillColor: WidgetStateProperty.all(Colors.white),side: const BorderSide(color: Colors.black)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.white),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white
      ),
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.black,
          onPrimary: Colors.black,
          secondary: Colors.green,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white.withOpacity(0.1),
          onSurface: Colors.white));
}
