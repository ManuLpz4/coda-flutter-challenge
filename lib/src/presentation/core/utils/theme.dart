import 'package:flutter/material.dart';

final lightTheme = ThemeData.from(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
).copyWith(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      fixedSize: const Size.fromHeight(40),
      shape: const StadiumBorder(),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size.fromHeight(40),
      shape: const StadiumBorder(),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      fixedSize: const Size.fromHeight(40),
      shape: const StadiumBorder(),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size.fromHeight(40),
      shape: const StadiumBorder(),
      surfaceTintColor: Colors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
);
