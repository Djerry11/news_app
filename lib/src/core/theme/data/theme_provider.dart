import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Define a provider for ThemeMode

class NewsThemeMode extends Notifier<ThemeMode> {
  @override
  build() {
    return ThemeMode.light;
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeModeProvider =
    NotifierProvider<NewsThemeMode, ThemeMode>(NewsThemeMode.new);
