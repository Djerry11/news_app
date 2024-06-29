import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/network/news_repository.dart';
import 'package:news_app/src/providers/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'trending_news_item.dart';

class TrendingNews extends ConsumerWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const trendingItems = 4;
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TrendingNewsHeader(),
        SizedBox(height: 10),
        TrendingNewsCarousel(trendingItems: trendingItems),
        SizedBox(height: 10),
        TrendingNewsIndicator(trendingItems: trendingItems),
      ],
    );
  }
}

class TrendingNewsHeader extends StatelessWidget {
  const TrendingNewsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Breaking news!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              // Add navigation to a detailed news list page
            },
            child: const Text(
              'See all',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrendingNewsCarousel extends ConsumerWidget {
  const TrendingNewsCarousel({
    required this.trendingItems,
    super.key,
  });

  final int trendingItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxWidth = MediaQuery.of(context).size.width;
    return ref
        .watch(
      fetchNewsProvider(
        category: 'general',
        page: 1,
        pageSize: 7,
      ),
    )
        .when(
      data: (data) {
        return CarouselSlider.builder(
          key: const PageStorageKey('carousel_slider'),
          options: CarouselOptions(
            autoPlay: false,
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
          itemCount: trendingItems,
          itemBuilder: (context, index, realIndex) {
            return TrendingNewsItem(
              article: data[index],
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
      effect: WormEffect(
        dotHeight: 10,
        dotWidth: 10,
        spacing: 10,
        dotColor: const Color.fromARGB(255, 243, 242, 242),
        activeDotColor: Colors.grey.shade900,
        paintStyle: PaintingStyle.fill,
      ),
    );
  }
}
