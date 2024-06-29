import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/features/home/presentation/widgets/news_tile.dart';

import 'package:news_app/src/providers/provider.dart';

class BookmarkPage extends ConsumerWidget {
  const BookmarkPage({super.key});

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
            return NewsTile(article: article);
          },
        ),
      ),
    );
  }
}
