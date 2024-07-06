import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/theme/domain/dark_theme.dart';
import 'package:news_app/src/core/theme/domain/light_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Define a provider for ThemeMode

class NewsThemeData extends Notifier<ThemeData> {
  @override
  build() {
    return lightThemeData;
  }

  void toggleTheme(BuildContext context) {
    state = state == lightThemeData ? darkThemeData : lightThemeData;
    ThemeSwitcher.of(context).changeTheme(theme: state);
  }

  bool isDarkMode() {
    return state == darkThemeData;
  }
}

final themeProvider =
    NotifierProvider<NewsThemeData, ThemeData>(NewsThemeData.new);
