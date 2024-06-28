import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/features/home/presentation/newslist.dart';
import 'package:news_app/src/features/home/presentation/trending/trending_news.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News World'),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              // Trending News
              TrendingNews(),
              // News List
              // SizedBox(height: 30),
              NewsList(),
            ],
          ),
        ),
      ),
    );
  }
}
