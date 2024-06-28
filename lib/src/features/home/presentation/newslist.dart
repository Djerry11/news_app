import 'package:flutter/material.dart';
import 'package:news_app/src/features/home/presentation/dummy_news.dart';
import 'news_tile.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'For you',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return NewsTile(
              imageUrl: newsItems[index]['urlToImage'],
              title: newsItems[index]['title'],
              author: newsItems[index]['author'],
              date: newsItems[index]['publishedAt'],
              sourceName: newsItems[index]['source']['name'],
            );
          },
        ),
      ],
    );
  }
}
