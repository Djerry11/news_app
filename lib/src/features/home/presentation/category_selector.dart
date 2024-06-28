import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/providers/provider.dart';

class NewsTile extends ConsumerWidget {
  final Articles article;
  const NewsTile({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkNotifier = ref.read(bookmarkProvider.notifier);
    final isBookmarked =
        ref.watch(bookmarkProvider).any((a) => a.url == article.url);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 90,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container for the article
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: article.urlToImage != null
                  ? CachedNetworkImage(
                      imageUrl: article.urlToImage!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey,
                        child: const Icon(Icons.image, color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey,
                        child: const Icon(Icons.error, color: Colors.red),
                      ),
                    )
                  : Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey,
                      child: const Icon(Icons.image, color: Colors.white),
                    ),
            ),
            const SizedBox(width: 8),
            // News Details section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.source?.name ?? 'Unknown Source',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    article.title ?? 'No title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    article.author ?? 'Unknown Author',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 8,
                    ),
                  ),
                  // Date and Time of the article
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 8),
                      Text(
                        article.publishedAt?.split('T').first ?? '',
                        style:
                            TextStyle(color: Colors.grey.shade600, fontSize: 8),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.timelapse, size: 8),
                      Text(
                        article.publishedAt?.split('T').last.split('Z').first ??
                            '',
                        style:
                            TextStyle(color: Colors.grey.shade600, fontSize: 8),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            // Bookmark button for the article
            IconButton(
              onPressed: () {
                isBookmarked
                    ? bookmarkNotifier.removeBookmark(article)
                    : bookmarkNotifier.addBookmark(article);
              },
              icon: Icon(
                isBookmarked ? Icons.favorite : Icons.favorite_border_outlined,
                color: isBookmarked ? Colors.red : Colors.green,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
