// // import 'package:dio/dio.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:news_app/src/core/models/articles.dart';

// import 'dart:convert';

// import 'package:news_app/src/core/utils/constants.dart';

// class NewsService {
//   Future<List<Articles>> fetchTopHeadlines() async {
//     final dio = Dio();
//     final uri = Uri(
//       scheme: 'https',
//       host: 'newsapi.org',
//       path: '/v2/top-headlines',
//       queryParameters: {
//         'country': 'us',
//         'apiKey': API_KEY,
//         'language': 'en',
//       },
//     );
//     final response = await dio.getUri(
//       uri,
//     );

//     final jsonResponse = response.data;
//     if (jsonResponse['status'] == 'ok') {
//       print('Top headlines loaded successfully');
//       final List<dynamic> data = jsonResponse['articles'];
//       return data
//           .map((article) => Articles.fromJson(article))
//           .where((article) =>
//               article.title?.isNotEmpty == true &&
//               article.description?.isNotEmpty == true &&
//               article.urlToImage?.isNotEmpty == true &&
//               article.publishedAt?.isNotEmpty == true &&
//               article.source?.name?.isNotEmpty == true)
//           .toList();
//     } else {
//       throw Exception('Failed to load top headlines');
//     }
//   }
// }
