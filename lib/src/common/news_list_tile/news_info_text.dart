import 'package:flutter/material.dart';
import 'package:news_app/src/core/utils/utils.dart';

class NewsInfoText extends StatelessWidget {
  const NewsInfoText(
      {super.key, this.source, this.title, this.author, this.publishedAt});
  final String? source;
  final String? title;
  final String? author;
  final String? publishedAt;

  @override
  Widget build(BuildContext context) {
    final formattedDate = formatDateTime(publishedAt ?? '').split('X');
    final date = formattedDate.first;
    final time = formattedDate.last;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            source ?? 'Unknown Source',
            maxLines: 1,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title ?? 'No title',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            author ?? 'Unknown Author',
            maxLines: 1,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 8,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 8),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 8),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.timelapse, size: 8),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 8),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
