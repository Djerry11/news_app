import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/features/home/presentation/widgets/news_tile.dart';
import 'package:news_app/src/providers/news_provider.dart';
// import 'news_tile.dart';s

class NewsList extends ConsumerWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsyncValue = ref.watch(articlesProvider);
    return articlesAsyncValue.when(
      data: (articles) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          itemExtent: 130,
          itemBuilder: (context, index) {
            final article = articles[index];
            return NewsTile(
              article: article,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
