import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/features/home/presentation/widgets/article_details.dart';
import 'package:news_app/src/features/home/presentation/widgets/bookmark_button.dart';
import 'package:news_app/src/features/home/presentation/widgets/image_container.dart';
import 'package:news_app/src/providers/provider.dart';

class NewsTile extends ConsumerWidget {
  final Articles article;
  const NewsTile({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = article.urlToImage;

    return GestureDetector(
      onTap: () {
        final articleJson = jsonEncode(article.toJson());
        final encodedArticleJson = Uri.encodeComponent(articleJson);
        context.push('/webViewArticle?article=$encodedArticleJson');
      },
      onDoubleTap: () {
        final bookmarkNotifier = ref.read(bookmarkProvider.notifier);
        final isBookmarked =
            ref.watch(bookmarkProvider).any((a) => a.url == article.url);
        isBookmarked
            ? bookmarkNotifier.removeBookmark(article)
            : bookmarkNotifier.addBookmark(article);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 90,
          width: double.maxFinite,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //

              ImageContainer(imageUrl: imageUrl!),
              const SizedBox(width: 8),
              Expanded(child: ArticleDetails(article: article)),
              //Favorite Button
              BookmarkButton(article: article),
            ],
          ),
        ),
      ),
    );
  }
}
