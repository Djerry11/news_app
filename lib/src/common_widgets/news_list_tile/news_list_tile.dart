import 'package:flutter/material.dart';
import 'package:news_app/src/common_widgets/news_list_tile/favorite_button.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_info_text.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_list_image.dart';

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

  static const imageWidth = 120.0;

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage;
    final source = article.source;
    final author = article.author;
    final publishedAt = article.publishedAt;
    final title = article.title;
    return Padding(
      padding: const EdgeInsets.only(
        top: 2,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: imageWidth,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onPressed,
              child: Stack(
                children: [
                  SizedBox(
                    width: imageWidth,
                    height: imageWidth,
                    child: NewsListImage(
                      imageUrl: imageUrl!,
                      imageWidth: imageWidth,
                    ),
                  ),
                  // debugging hint to show the tile index
                  // if (debugIndex != null) ...[
                  //   Positioned(
                  //     left: 4,
                  //     top: 4,
                  //     child: Text(
                  //       '$debugIndex',
                  //       style:
                  //           const TextStyle(color: Colors.white, fontSize: 14),
                  //     ),
                  //   ),
                  // ]
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
      ),
    );
  }
}
