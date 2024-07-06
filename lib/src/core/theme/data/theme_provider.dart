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
    return darkThemeData;
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

//
class TrendingSliderValue extends Notifier<bool> {
  @override
  build() {
    return true;
  }

  void toggle() {
    state = !state;
  }
}

final trendingSliderProvider =
    NotifierProvider<TrendingSliderValue, bool>(TrendingSliderValue.new);

//disable button for 2 seconds
class DisableButton extends Notifier<bool> {
  @override
  build() {
    return false;
  }

  void disable() {
    state = true;
    Future.delayed(const Duration(seconds: 2, milliseconds: 100), () {
      state = false;
    });
  }
}

final disableButtonProvider =
    NotifierProvider<DisableButton, bool>(DisableButton.new);
