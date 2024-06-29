import 'package:flutter/material.dart';
import 'package:news_app/src/common/news_list_tile/favorite_button.dart';
import 'package:news_app/src/common/news_list_tile/news_info_text.dart';
import 'package:news_app/src/common/news_list_tile/news_list_image.dart';
import 'package:news_app/src/common/news_list_tile/top_gradient.dart';
import 'package:news_app/src/core/models/articles.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({
    super.key,
    required this.article,
    // debugging hint to show the tile index
    this.debugIndex,
    this.onPressed,
  });
  final Articles article;
  final int? debugIndex;
  final VoidCallback? onPressed;

  static const posterHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage;
    final source = article.source;
    final author = article.author;
    final publishedAt = article.publishedAt;
    final title = article.title;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Stack(
              children: [
                SizedBox(
                  width: posterHeight,
                  height: posterHeight,
                  child: NewsListImage(
                    imageUrl: imageUrl!,
                  ),
                ),
                if (debugIndex != null) ...[
                  const Positioned.fill(child: TopGradient()),
                  Positioned(
                    left: 4,
                    top: 4,
                    child: Text(
                      '$debugIndex',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(width: 8),
          //news info text
          NewsInfoText(
            source: source!.name,
            title: title,
            author: author,
            publishedAt: publishedAt,
          ),
          //favorite button
          FavoriteButton(
            article: article,
          ),
        ],
      ),
    );
  }
}
