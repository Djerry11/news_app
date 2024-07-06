import 'package:flutter/material.dart';
import 'package:news_app/src/core/theme/domain/text_theme.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,

  //----------------------------------------
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: customTextTheme.displayLarge?.copyWith(color: Colors.black),
  ),
  //----------------------------------------
  textTheme: customTextTheme.copyWith(
    titleSmall: const TextStyle(color: Colors.black54),
    // bodyColor: Colors.black,
    displayMedium: TextStyle(
      fontFamily: 'Agbalumo',
      fontSize: 28,
      color: Colors.grey.shade600,
    ),
  ),

  //------------------shimmer tile----------------------
  highlightColor: Colors.black12,
  shadowColor: Colors.black54,

  //----------------------------------------
  iconTheme: const IconThemeData(color: Colors.black54),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all(Colors.black54),
      backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
    ),
  ),
  //----------------------------------------
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  //----------------------------------------
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
  ),
);
