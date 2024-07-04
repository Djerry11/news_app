import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/src/features/home/presentation/trending/trending_news_carousel.dart';
import 'package:news_app/src/features/home/presentation/trending/trending_news_indicator.dart';

class TrendingNews extends ConsumerWidget {
  const TrendingNews({super.key, required this.category});
  final String? category;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const trendingItems = 5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TrendingNewsHeader(category: category),
        TrendingNewsCarousel(trendingItems: trendingItems, category: category),
        const SizedBox(height: 10),
        const TrendingNewsIndicator(trendingItems: trendingItems),
      ],
    );
  }
}

class TrendingNewsHeader extends StatelessWidget {
  const TrendingNewsHeader({super.key, required this.category});
  final String? category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Breaking news!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  //TODO: Implement the see all button
                },
                icon: const Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.shade400,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              category!.toUpperCase(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
