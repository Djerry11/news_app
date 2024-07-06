import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/core/theme/data/theme_provider.dart';

import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/features/home/presentation/widgets/newslist.dart';
import 'package:news_app/src/features/home/presentation/trending/trending_news.dart';
import 'package:news_app/src/features/home/presentation/widgets/round_icon_button.dart';
import 'package:news_app/src/localization/extensions.dart';
import 'package:news_app/src/providers/provider.dart';
import 'package:news_app/src/routes/app_routes.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();
  int index = 0;
  NewsCategory category = NewsCategory.values[0]; // Initialize category

  void changeCategory() {
    // ref.read(trendingIndexProvider.notifier).setIndex(0);
    setState(() {
      category = NewsCategory.values[(index++) % NewsCategory.values.length];
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // const isOnline = true;
    // final isOnline = ref.watch(connectivityNotifierProvider);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundIconButton(
                onPressed: () {
                  ref.read(themeModeProvider.notifier).toggleTheme();
                },
                icon: Icons.menu,
                iconColor: Colors.black87,
              ),
            ),
            title: Text(
              'NewsPulse'.hardcoded,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            actions: [
              RoundIconButton(
                onPressed: () {
                  context.goNamed(AppRoute.discover.name);
                },
                icon: CupertinoIcons.search,
                iconColor: Colors.black87,
              ),
              RoundIconButton(
                onPressed: () {},
                icon: Icons.notifications_outlined,
                iconColor: Colors.black87,
              ),
              const SizedBox(width: 15)
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              changeCategory();
              ref.read(trendingIndexProvider.notifier).setIndex(0);
            },
            child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trending News
                    TrendingNews(
                      scrollController: _scrollController,
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
          // : NoInternetConnection(onRefresh: () {}),
          ),
    );
  }
}
