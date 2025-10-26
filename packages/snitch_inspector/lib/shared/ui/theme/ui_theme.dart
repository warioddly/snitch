

import 'package:flutter/material.dart';

final class UITheme {


  // static final lightTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primarySwatch: Colors.blue,
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  // );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(0)
      )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(0)
      ),
    ),
  );

}