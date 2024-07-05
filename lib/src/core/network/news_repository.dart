import 'dart:async';
import 'package:dio/dio.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/core/network/internet_service.dart';
import 'package:news_app/src/core/utils/dio_provider.dart';
import 'package:news_app/src/core/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_repository.g.dart';

class NewsRepository {
  NewsRepository({required this.client, required this.apiKey});
  final Dio client;
  final String apiKey;

  //fetch top headlines :: endpoint: /v2/top-headlines
  Future<List<Articles>> fetchTopHeadlines({
    int page = 1,
    String country = 'us',
    String? category,
    CancelToken? cancelToken,
    int pageSize = 20,
  }) async {
    // Create the News api URI for the top headlines.
    final uri = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: '/v2/top-headlines',
      queryParameters: {
        'country': country,
        'apiKey': apiKey,
        'page': '$page',
        'language': 'en',
        'pageSize': '$pageSize',
        if (category != null) 'category': category,
      },
    );

    try {
      final response = await client.getUri(uri, cancelToken: cancelToken);
      final jsonResponse = response.data;
      if (jsonResponse['status'] == 'ok' && jsonResponse['totalResults'] > 0) {
        final List<dynamic> data = jsonResponse['articles'];
        return data
            .map((article) => Articles.fromJson(article))
            .where((article) =>
                article.title?.isNotEmpty == true &&
                article.description?.isNotEmpty == true &&
                article.urlToImage?.isNotEmpty == true &&
                article.publishedAt?.isNotEmpty == true &&
                article.source?.name?.isNotEmpty == true)
            .toList();
      } else {
        throw Exception('Failed to load top headlines');
      }
    } catch (e) {
      throw Exception('Failed to load top headlines: $e');
    }
  }

  //------------------## EveryThing EndPoint ##------------------
  //search the news with query :: endpoint: /v2/everything
  Future<List<Articles>> searchNews({
    int page = 1,
    String query = 'news',
    String sortBy = 'publishedAt',
    CancelToken? cancelToken,
  }) async {
    // Create the News api URI for the search query everything.
    final uri = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: '/v2/everything',
      queryParameters: {
        'apiKey': apiKey,
        'page': '$page',
        'q': query,
        'sortBy': sortBy,
      },
    );

    try {
      final response = await client.getUri(uri, cancelToken: cancelToken);
      final jsonResponse = response.data;
      if (jsonResponse['status'] == 'ok' && jsonResponse['totalResults'] > 0) {
        final List<dynamic> data = jsonResponse['articles'];
        return data
            .map((article) => Articles.fromJson(article))
            .where((article) =>
                article.title?.isNotEmpty == true &&
                article.description?.isNotEmpty == true &&
                article.urlToImage?.isNotEmpty == true &&
                article.publishedAt?.isNotEmpty == true &&
                article.source?.name?.isNotEmpty == true)
            .toList();
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
}

@riverpod
NewsRepository newsRepository(NewsRepositoryRef ref) => NewsRepository(
      client: ref.watch(dioProvider),
      apiKey: getApiKey(),
    );

/// Provider to fetch news articles, either top headlines or search results, with pagination.
@riverpod
Future<List<Articles>> fetchNews(
  FetchNewsRef ref, {
  int page = 1,
  String query = '',
  String? sortBy,
  String country = 'us',
  String? category,
  int pageSize = 20,
}) async {
  final newsRepo = ref.watch(newsRepositoryProvider);
  final isOnline = ref.watch(connectivityNotifierProvider);

  if (!isOnline) {
    throw Exception('No Internet Connection');
  }

  // Cancel token to cancel the request if necessary.
  final cancelToken = CancelToken();

  // Keep the provider alive for a certain duration to prevent re-fetching.
  final link = ref.keepAlive();
  Timer? timer;

  // Dispose the request and the timer when the provider is disposed.
  ref.onDispose(() {
    cancelToken.cancel();
    timer?.cancel();
  });

  // Start a timer to dispose the cached data after a certain period when the provider is not used.
  ref.onCancel(() {
    timer = Timer(const Duration(seconds: 30), () {
      link.close(); // kill the link
    });
  });

  // Cancel the timer if the provider is resumed.
  ref.onResume(() {
    timer?.cancel();
  });

  // Fetch data based on the query or top headlines.
  //if query is not empty and category is null, search the news with query
  if (query.isNotEmpty && category == null) {
    return newsRepo.searchNews(
      page: page,
      query: query,
      sortBy: sortBy ?? 'relevance',
      cancelToken: cancelToken,
    );
  } else {
    return newsRepo.fetchTopHeadlines(
      page: page,
      country: country,
      category: category,
      pageSize: pageSize,
      cancelToken: cancelToken,
    );
  }
}
