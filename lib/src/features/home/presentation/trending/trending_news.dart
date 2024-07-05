import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/src/features/home/presentation/trending/trending_news_carousel.dart';
import 'package:news_app/src/features/home/presentation/trending/trending_news_indicator.dart';
import 'package:news_app/src/localization/extensions.dart';

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
              Text(
                'Breaking news!',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade600,
                    ),
              ),
              IconButton(
                onPressed: () {
                  //TODO: Implement the see all button
                },
                icon: const Icon(
                  CupertinoIcons.list_dash,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.purple.shade400,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              category!.toCapitalized(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
