import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/common_widgets/no_internet_connection.dart';
import 'package:news_app/src/core/network/internet_service.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/features/home/presentation/widgets/newslist.dart';
import 'package:news_app/src/features/home/presentation/trending/trending_news.dart';
import 'package:news_app/src/providers/provider.dart';

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
  Widget build(BuildContext context) {
    const isOnline = true;
    // final isOnline = ref.watch(connectivityNotifierProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Colors.grey.shade100,
              ),
            ),
            icon: const Icon(
              CupertinoIcons.line_horizontal_3,
              fill: 0.9,
              size: 28,
              color: Colors.black87,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        body: isOnline
            ? RefreshIndicator(
                onRefresh: () async {
                  changeCategory();
                  ref.read(trendingIndexProvider.notifier).setIndex(0);
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'For you',
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: 18,
                                ),
                      ),
                    ),
                    NewsList(
                      category: category.name,
                    ),
                  ],
                )),
              )
            : NoInternetConnection(onRefresh: () {}),
      ),
    );
  }
}
