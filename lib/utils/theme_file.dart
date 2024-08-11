import 'package:flutter/material.dart';

class ThemeEdit {
  static ThemeData lightTheme = ThemeData(
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
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.white),
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
