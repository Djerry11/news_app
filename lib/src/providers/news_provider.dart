// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:news_app/src/core/models/articles.dart';
// import 'news_services.dart';

// final newsServiceProvider = Provider<NewsService>((ref) {
//   return NewsService();
// });

// final articlesProvider = FutureProvider<List<Articles>>((ref) async {
//   final newsService = ref.watch(newsServiceProvider);
//   return newsService.fetchTopHeadlines();
// });
