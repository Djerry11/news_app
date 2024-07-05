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
  textTheme: customTextTheme.apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  //----------------------------------------
  iconTheme: const IconThemeData(color: Colors.black),
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
