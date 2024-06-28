// import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:news_app/src/core/models/articles.dart';

import 'dart:convert';

class NewsService {
  Future<List<Articles>> fetchTopHeadlines() async {
    final String jsonString =
        await rootBundle.loadString('assets/dummy_response.json');

    final jsonResponse = jsonDecode(jsonString);

    if (jsonResponse['status'] == 'ok') {
      print('Top headlines loaded successfully');
      final List<dynamic> data = jsonResponse['articles'];
      return data
          .map((article) => Articles.fromJson(article))
          .where((article) =>
              article.title?.isNotEmpty == true &&
              article.description?.isNotEmpty == true &&
              article.urlToImage?.isNotEmpty == true)
          .toList();
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
