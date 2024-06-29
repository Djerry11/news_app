import 'package:flutter/material.dart';
import 'package:news_app/src/core/models/articles.dart';

class ArticleDetails extends StatelessWidget {
  final Articles article;
  const ArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.source?.name ?? 'Unknown Source',
          maxLines: 1,
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
          maxLines: 1,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 8,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 8),
            Text(
              article.publishedAt?.split('T').first ?? '',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 8),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.timelapse, size: 8),
            Text(
              article.publishedAt?.split('T').last.split('Z').first ?? '',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 8),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
