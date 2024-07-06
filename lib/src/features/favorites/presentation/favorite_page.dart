import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/src/common_widgets/connection_errors/something_went_wrong.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_tile_shimmer.dart';
import 'package:news_app/src/features/favorites/data/favorite_controller.dart';
import 'package:news_app/src/localization/extensions.dart';

import 'package:news_app/src/routes/app_routes.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final articles = ref.watch(bookmarkProvider);
    final localArticlesAsync = ref.watch(favoriteNotifierProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bookmarks'.hardcoded,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 28,
                  color: const Color(0xFF867f7f),
                ),
          ),
        ),
        body: localArticlesAsync.when(
          data: (orgArticles) {
            final articles = orgArticles.reversed.toList();
            if (articles.isEmpty) {
              return Center(
                child: Lottie.asset('assets/animations/empty_animation.json'),
              );
            }

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: NewsListTile(
                        article: article,
                        onPressed: () {
                          context.pushNamed(
                            AppRoute.webViewArticle.name,
                            pathParameters: {
                              'id': article.source!.name!,
                            },
                            extra: article,
                          );
                        }));
              },
            );
          },
          error: (_, __) {
            return const Flexible(child: SomethingWentWrong());
          },
          loading: () => ListView.builder(
              itemExtent: 120,
              itemCount: 3,
              itemBuilder: (context, index) {
                return const NewsTileShimmer();
              }),
        ),
      ),
    );
  }
}
