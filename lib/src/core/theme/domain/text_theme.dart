import 'package:flutter/material.dart';

const customTextTheme = TextTheme(
  //news source section
  displayLarge: TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontVariations: [
      FontVariation('wght', 700),
    ],
  ),
  //Heading section app bar section
  displayMedium: TextStyle(
    fontFamily: 'Agbalumo',
    fontSize: 28,
  ),
  //trending news title
  bodyLarge: TextStyle(
    fontFamily: 'OpenSans',
    color: Colors.white,
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
  //news list title
);
