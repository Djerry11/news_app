import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/providers/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'trending_news_item.dart';

class TrendingNews extends ConsumerWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const trendingItems = 4;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Breaking news!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(flex: 7),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(flex: 1)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            CarouselSlider.builder(
              key: const PageStorageKey('carousel_slider'),
              options: CarouselOptions(
                autoPlay: false,
                height: 250,
                viewportFraction: 0.9,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayInterval: const Duration(seconds: 2),
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  ref.read(trendingIndexProvider.notifier).setIndex(index);
                },
              ),
              itemCount: trendingItems,
              itemBuilder: (context, index, realIndex) {
                return const TrendingNewsItem();
              },
            ),
            const SizedBox(height: 10),
            AnimatedSmoothIndicator(
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
            ),
          ],
        ),
      ],
    );
  }
}
