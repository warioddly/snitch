import 'package:flutter/material.dart';


enum SnitchThemeType {
  LIGHT,
  DARK,
}

class SnitchTheme {


  static ThemeData getTheme(SnitchThemeType theme) {
    switch (theme) {
      case SnitchThemeType.LIGHT:
        return _lightTheme();
      case SnitchThemeType.DARK:
        return _darkTheme();
      default:
        return _lightTheme();
    }
  }


  static ThemeData _lightTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      colorScheme: const ColorScheme.light(
        surface: Color(0xFFFFFFFF),
        primary: Color(0xFFFFFFFF),
        secondary: Color(0xFFA0A0A5),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        surfaceTintColor: Color(0xFF141718),
        iconTheme: IconThemeData(
          color: Color(0xFFBDBDBD),
          size: 20,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFFBDBDBD),
        size: 20,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFCFCFD),
        selectedItemColor: Color(0xFFBDBDBD),
        unselectedItemColor: Color(0xFFBDBDBD),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedLabelStyle: TextStyle(
          color: Color(0xFF9E9E9E),
          fontSize: 20,
        ),
        selectedIconTheme: IconThemeData(
          color: Color(0xFF141416),
          size: 22,
        ),
        unselectedIconTheme: IconThemeData(
          color: Color(0xFF9E9E9E),
          size: 22,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        textColor: Color(0xFF212121),
        subtitleTextStyle: TextStyle(
          color: Color(0xFF737373),
          fontSize: 12,
        ),
        titleTextStyle: TextStyle(
          color: Color(0xFF212121),
          fontSize: 16,
        ),
      ),
    );
  }


  static ThemeData _darkTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF141718),
      colorScheme: const ColorScheme.dark(
        surface: Color(0xFF121718),
        primary: Color(0xFFFFFFFF),
        secondary: Color(0xFFA0A0A5),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(0xFF141718),
        surfaceTintColor: Color(0xFF141718),
        iconTheme: IconThemeData(
          color: Color(0xFFBDBDBD),
          size: 20,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFFBDBDBD),
        size: 20,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF141718),
        selectedItemColor: Color(0xFFBDBDBD),
        unselectedItemColor: Color(0xFFBDBDBD),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedLabelStyle: TextStyle(
          color: Color(0xFFBDBDBD),
          fontSize: 20,
        ),
        selectedIconTheme: IconThemeData(
          color: Color(0xFFFFFFFF),
          size: 22,
        ),
        unselectedIconTheme: IconThemeData(
          color: Color(0xFFBDBDBD),
          size: 22,
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        textColor: Color(0xFFA7A7AB),
        subtitleTextStyle: TextStyle(
          color: Color(0xFFBDBDBD),
          fontSize: 12,
      ),
          titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 16,
        ),
      ),
    );
  }

}