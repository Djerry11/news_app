import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Page'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Favorites Page'),
          ),
          ElevatedButton(
            onPressed: () {
              context.pushNamed('articleDetail',
                  pathParameters: {'articleId': '123'});
            },
            child: const Text('Article Details'),
          )
        ],
      ),
    );
  }
}
