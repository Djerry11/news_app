import 'package:flutter/material.dart';

/// A simple placeholder that can be used to search all the hardcoded strings
/// in the code (useful to identify strings that need to be localized).
extension StringHardcoded on String {
  String get hardcoded => this;
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

// resize the image according to the device's pixel ratio
extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}
