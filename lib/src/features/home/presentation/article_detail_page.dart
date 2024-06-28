import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({super.key, required this.articleId});
  final String articleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Detail Page'),
      ),
      body: Center(
        child: Text('Article Id: $articleId'),
      ),
    );
  }
}
