import 'package:flutter_riverpod/flutter_riverpod.dart';

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
