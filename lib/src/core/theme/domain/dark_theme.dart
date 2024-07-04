import 'package:flutter/material.dart';
import 'package:news_app/src/core/theme/domain/text_theme.dart';

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  //----------------------------------------
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: customTextTheme.displayLarge?.copyWith(color: Colors.white),
  ),
  //----------------------------------------
  textTheme: customTextTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  //----------------------------------------
  iconTheme: const IconThemeData(color: Colors.white),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
  //----------------------------------------
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
  ),
);
