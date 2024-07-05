import 'dart:async';
import 'package:news_app/src/core/network/news_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_query_notifier.g.dart';

/// A notifier class to keep track of the search query (with debouncing)
@riverpod
class NewsQueryNotifier extends _$NewsQueryNotifier {
  /// Used to debounce the input queries
  Timer? _debounceTimer;

  @override
  String build() {
    // cancel the subscriptions on dispose
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    // by default, return an empty query
    return '';
  }

  void setQuery(String query) {
    // Cancel the timer if it is active
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }
    ref.invalidate(fetchNewsProvider);
    _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
      // only update the state once the query has been debounced
      state = query;
    });
  }

  void clearQuery() {
    state = '';
  }
}
