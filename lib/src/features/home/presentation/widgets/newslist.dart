import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/core/network/news_repository.dart';

import 'package:news_app/src/routes/app_routes.dart';

// import 'news_tile.dart';s

class NewsList extends ConsumerWidget {
  const NewsList({super.key, required this.category});
  final String? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(fetchNewsProvider(category: category));

    return articlesAsync.when(
      data: (articles) {
        final tLength = articles.length - 4;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tLength,
          itemBuilder: (context, index) {
            final offsetIndex = index + 4;
            final article = articles[offsetIndex];
            return SizedBox(
              height: 120,
              width: double.infinity,
              child: NewsListTile(
                article: article,
                onPressed: () => context.pushNamed(
                  AppRoute.webViewArticle.name,
                  pathParameters: {
                    'id': article.source!.name!,
                  },
                  extra: article,
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
