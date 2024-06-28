import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/models/articles.dart';

//Provider to watch change and get change
final trendingIndexProvider = StateNotifierProvider<TrendingIndex, int>((ref) {
  return TrendingIndex();
});

class TrendingIndex extends StateNotifier<int> {
  TrendingIndex() : super(0);

  void setIndex(value) {
    state = value;
  }

  int get index => state;
}

// Provider to change the bookmark status
final bookmarkProvider =
    StateNotifierProvider<BookmarkNotifier, List<Articles>>((ref) {
  return BookmarkNotifier();
});

class BookmarkNotifier extends StateNotifier<List<Articles>> {
  BookmarkNotifier() : super([]);

  void addBookmark(Articles article) {
    state = [...state, article.copyWith(isBookmarked: true)];
  }

  void removeBookmark(Articles article) {
    state = state.where((a) => a.url != article.url).toList();
  }

  bool isBookmarked(Articles article) {
    return state.any((a) => a.url == article.url);
  }

  void printBookmark() {
    print(state.length);
  }
}
