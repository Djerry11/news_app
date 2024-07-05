import 'package:flutter/material.dart';

const customTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontVariations: [
      FontVariation('wght', 700),
    ],
  ),
  displayMedium: TextStyle(
    fontFamily: 'Agbalumo',
    fontSize: 30,
    color: Color(0xFF867f7f),
  ),
  bodyLarge: TextStyle(
    fontFamily: 'OpenSans',
    fontVariations: [
      FontVariation('wght', 500),
    ],
  ),
  bodyMedium: TextStyle(
    fontFamily: 'OpenSans',
    fontVariations: [
      FontVariation('wght', 700),
    ],
  ),
  titleMedium: TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontStyle: FontStyle.italic,
    fontVariations: [
      FontVariation('wght', 400),
    ],
  ),
  titleSmall: TextStyle(
    fontFamily: 'OpenSans',
    fontVariations: [
      FontVariation('wght', 400),
    ],
  ),
);
