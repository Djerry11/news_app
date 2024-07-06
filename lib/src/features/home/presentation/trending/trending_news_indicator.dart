import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/providers/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TrendingNewsIndicator extends ConsumerWidget {
  const TrendingNewsIndicator({
    required this.trendingItems,
    super.key,
  });

  final int trendingItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSmoothIndicator(
      activeIndex: ref.watch(trendingIndexProvider),
      count: trendingItems,
      effect: const WormEffect(
        dotHeight: 10,
        dotWidth: 10,
        spacing: 10,
        dotColor: Color.fromARGB(255, 199, 184, 184),
        activeDotColor: Colors.deepPurpleAccent,
        paintStyle: PaintingStyle.fill,
      ),
    );
  }
}
