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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(source ?? 'Unknown Source',
                maxLines: 1,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 11,
                    )),
          ),
          Text(
            title ?? 'No title',
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          Text(
            author ?? 'Unknown Author',
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Flexible(
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 8),
                Text(
                  date,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 8,
                      ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.timelapse, size: 8),
                Text(
                  time,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 8,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
