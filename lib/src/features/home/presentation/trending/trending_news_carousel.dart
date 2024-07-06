import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/network/news_repository.dart';
import 'package:news_app/src/features/home/presentation/trending/trending_news_item.dart';
import 'package:news_app/src/providers/provider.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsCarousel extends ConsumerWidget {
  const TrendingNewsCarousel({
    required this.trendingItems,
    this.category,
    super.key,
  });

  final int trendingItems;
  final String? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var autoPlay = false;
    if (!kDebugMode) {
      autoPlay = !autoPlay;
    }
    final maxWidth = MediaQuery.of(context).size.width;
    final trendingNewsAsync = ref.watch(
      fetchNewsProvider(
        category: category ?? 'general',
        page: 1,
        pageSize: 10,
      ),
    );
    return trendingNewsAsync.when(
      data: (data) {
        final itemCounts =
            trendingItems < data.length ? trendingItems : data.length;
        return CarouselSlider.builder(
          key: const PageStorageKey('carousel_slider'),
          options: CarouselOptions(
            autoPlay: autoPlay,
            height: 250,
            viewportFraction: 0.9,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            initialPage: 0,
            onPageChanged: (index, reason) {
              ref.read(trendingIndexProvider.notifier).setIndex(index);
            },
          ),
          itemCount: itemCounts,
          itemBuilder: (context, index, realIndex) {
            return TrendingNewsItem(
              article: data[index],
              maxWidth: maxWidth,
            );
          },
        );
      },
      error: (err, stk) {
        return SizedBox(
            height: 250,
            width: maxWidth * 0.9,
            child: const Center(
                child: Icon(
              Icons.error_outline,
            )));
      },
      loading: () {
        //create shimmer effect for the trending items
        return Shimmer.fromColors(
            baseColor: Colors.black26,
            highlightColor: Colors.black12,
            child: Container(
              height: 250,
              width: maxWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ));
      },
    );
  }
}
