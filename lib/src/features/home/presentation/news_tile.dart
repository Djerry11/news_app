import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String date;
  final String sourceName;
  final bool isSaved;

  const NewsTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.date,
    required this.sourceName,
    this.isSaved = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 90,
        // color: Colors.grey,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sourceName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    author,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 8,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 8),
                      Text(
                        date.split('T').first,
                        style:
                            TextStyle(color: Colors.grey.shade600, fontSize: 8),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.timelapse, size: 8),
                      Text(
                        date.split('T').last.split('Z').first,
                        style:
                            TextStyle(color: Colors.grey.shade600, fontSize: 8),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
            Consumer(builder: (context, ref, child) {
              // ref.read(isSavedProvider).state;
              //Todo:
              return IconButton(
                onPressed: () {},
                icon: Icon(
                  isSaved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_outline_rounded,
                  color: isSaved ? Colors.green : Colors.grey,
                  size: 30,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
