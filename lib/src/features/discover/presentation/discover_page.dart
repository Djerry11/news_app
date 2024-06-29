import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/common/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:news_app/src/routes/app_routes.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsyncValue = ref.watch(articlesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
      ),
      body: articlesAsyncValue.when(
        data: (articles) {
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return NewsListTile(
                article: article,
                debugIndex: index + 1,
                onPressed: () {
                  context.pushNamed(
                    AppRoute.discover.name,
                    pathParameters: {'id': article.url.toString()},
                    extra: article,
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
