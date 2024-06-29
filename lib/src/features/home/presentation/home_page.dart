import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/features/home/presentation/widgets/newslist.dart';
import 'package:news_app/src/features/home/presentation/trending/trending_news.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int index = 0;
  NewsCategory category = NewsCategory.values[0]; // Initialize category

  void changeCategory() {
    // ref.read(trendingIndexProvider.notifier).setIndex(0);
    setState(() {
      category = NewsCategory.values[(index++) % NewsCategory.values.length];
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'News World',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            changeCategory();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trending News
                TrendingNews(
                  category: category.name,
                ),
                // News List
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'For you',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                NewsList(
                  category: category.name,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
