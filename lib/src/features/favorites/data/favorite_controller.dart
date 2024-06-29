import 'package:news_app/src/core/models/articles.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

part 'favorite_controller.g.dart';

@riverpod
class FavoriteNotifier extends _$FavoriteNotifier {
  @override
  FutureOr<List<Articles>> build() async {
    // Ensure that the state is only built once at initialization
    state = await _loadBookmarks();
    return state.value ?? [];
  }

  Future<void> addFavorites(Articles article) async {
    final currentState = state;
    if (currentState is AsyncData<List<Articles>>) {
      final updatedList = [
        ...currentState.value,
        article.copyWith(isBookmarked: true)
      ];
      state = AsyncData(updatedList);
      await _saveBookmarks(updatedList);
    }
  }

  Future<void> removeFavorites(Articles article) async {
    final currentState = state;
    if (currentState is AsyncData<List<Articles>>) {
      final updatedList =
          currentState.value.where((a) => a.url != article.url).toList();
      state = AsyncData(updatedList);
      await _saveBookmarks(updatedList);
    }
  }

  Future<void> _saveBookmarks(List<Articles> articles) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString =
        jsonEncode(articles.map((article) => article.toJson()).toList());
    await prefs.setString('fav_articles', jsonString);
  }

  Future<AsyncData<List<Articles>>> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('fav_articles');
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return AsyncData(decoded.map((json) => Articles.fromJson(json)).toList());
    }
    return const AsyncData([]);
  }
}
