import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/features/favorites/data/favorite_controller.dart';

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
            'Bookmarks',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey.shade600,
                ),
          ),
        ),
        body: localArticlesAsync.when(
          data: (articles) {
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
            return const Center(child: Text('Error'));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
