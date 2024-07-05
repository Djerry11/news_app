import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/features/favorites/data/favorite_controller.dart';

class FavoriteButton extends ConsumerWidget {
  final Articles article;
  const FavoriteButton({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkNotifier = ref.read(favoriteNotifierProvider.notifier);

    final isFavorite = ref
            .watch(favoriteNotifierProvider)
            .value
            ?.any((a) => a.url == article.url) ??
        false;

    return IconButton(
      onPressed: () {
        isFavorite
            ? bookmarkNotifier.removeFavorites(article)
            : bookmarkNotifier.addFavorites(article);
      },
      icon: Icon(
        isFavorite ? Icons.bookmark : Icons.bookmark_outline,
        color: Colors.deepPurple,
        size: 30,
      ),
    );
  }
}
