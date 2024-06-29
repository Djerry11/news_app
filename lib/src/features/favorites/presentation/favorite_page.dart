import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/common/news_list_tile/news_list_tile.dart';

import 'package:news_app/src/providers/provider.dart';
import 'package:news_app/src/routes/app_routes.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(bookmarkProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favorites News',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
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
        ),
      ),
    );
  }
}
