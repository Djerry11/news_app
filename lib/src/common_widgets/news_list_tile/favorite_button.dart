import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/providers/provider.dart';

class FavoriteButton extends ConsumerWidget {
  final Articles article;
  const FavoriteButton({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkNotifier = ref.read(bookmarkProvider.notifier);
    final isBookmarked =
        ref.watch(bookmarkProvider).any((a) => a.url == article.url);

    return IconButton(
      onPressed: () {
        isBookmarked
            ? bookmarkNotifier.removeBookmark(article)
            : bookmarkNotifier.addBookmark(article);
      },
      icon: Icon(
        isBookmarked ? Icons.favorite : Icons.favorite_border_outlined,
        color: isBookmarked ? Colors.red : Colors.deepPurpleAccent,
        size: 30,
      ),
    );
  }
}
