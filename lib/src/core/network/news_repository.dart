import 'dart:async';

import 'package:dio/dio.dart';
import 'package:news_app/src/core/models/news_api_response.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/core/utils/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_repository.g.dart';

typedef NewsQueryData = ({
  int page,
  String query,
  String? sortBy,
  String? category
});

class NewsRepository {
  NewsRepository({required this.client, required this.apiKey});
  final Dio client;
  final String apiKey;
  Future<NewsApiResponse> fetchTopHeadlines(
      {required int page, CancelToken? cancelToken}) async {
    final uri = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: '/v2/top-headlines',
      queryParameters: {
        'country': 'us',
        'apiKey': apiKey,
        'page': '$page',
        'language': 'en',
      },
    );
    // print('uri: ${uri.toString()}');
    final response = await client.getUri(uri, cancelToken: cancelToken);
    return NewsApiResponse.fromJson(response.data);
  }

  Future<NewsApiResponse> searchNews(
      {required NewsQueryData queryData, CancelToken? cancelToken}) async {
    final uri = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: '/v2/everything',
      queryParameters: {
        'api_key': apiKey,
        'page': '${queryData.page}',
        'q': queryData.query,
        'sortBy': queryData.sortBy ?? 'publishedAt',
      },
    );
    final response = await client.getUri(uri, cancelToken: cancelToken);
    return NewsApiResponse.fromJson(response.data);
  }

  Future<NewsApiResponse> searchNewsByCategory(
      {required NewsQueryData queryData, CancelToken? cancelToken}) async {
    final uri = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: '/v2/top-headlines',
      queryParameters: {
        'api_key': apiKey,
        'page': '${queryData.page}',
        'sortBy': queryData.sortBy ?? 'publishedAt',
      },
    );
    final response = await client.getUri(uri, cancelToken: cancelToken);
    return NewsApiResponse.fromJson(response.data);
  }
}

@riverpod
NewsRepository newsRepository(NewsRepositoryRef ref) =>
    NewsRepository(client: ref.watch(dioProvider), apiKey: API_KEY);

// class AbortedException implements Exception {}

// @riverpod
// Future<NewsApiResponse> fetchNews(FetchNewsRef ref, int page,
//     {required NewsQueryData queryData}) async {
//   final newsRepo = ref.watch(newsRepositoryProvider);
//   return newsRepo.fetchTopHeadlines(page: page);
// }

/// Provider to fetch paginated news data
@riverpod
Future<NewsApiResponse> fetchNews(
  FetchNewsRef ref, {
  required NewsQueryData queryData,
}) async {
  final newsRepo = ref.watch(newsRepositoryProvider);
  // See this for how the timeout is implemented:
  // Cancel the page request if the UI no longer needs it.
  // This happens if the user scrolls very fast or if we type a different search term.
  final cancelToken = CancelToken();
  // When a page is no-longer used, keep it in the cache.
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    cancelToken.cancel();
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });
  if (queryData.query.isEmpty) {
    // fetch top headlines
    return newsRepo.fetchTopHeadlines(
      page: queryData.page,
      cancelToken: cancelToken,
    );
  } else if (queryData.category != null) {
    // fetch top headlines by category
    return newsRepo.searchNewsByCategory(
      queryData: queryData,
      cancelToken: cancelToken,
    );
  } else {
    // use default search for everything
    return newsRepo.searchNews(
      queryData: queryData,
      cancelToken: cancelToken,
    );
  }
}
