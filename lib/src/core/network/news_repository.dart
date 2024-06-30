import 'dart:async';
import 'package:dio/dio.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/core/utils/dio_provider.dart';
import 'package:news_app/src/core/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_repository.g.dart';

class NewsRepository {
  NewsRepository({required this.client, required this.apiKey});
  final Dio client;
  final String apiKey;

  /// Fetch top headlines from the news API.
  ///
  /// [page] specifies the page number for pagination.
  /// [country] specifies the country code for the headlines.
  /// [category] specifies the news category.
  /// [cancelToken] allows canceling the request if necessary.
  Future<List<Articles>> fetchTopHeadlines({
    int page = 1,
    String country = 'us',
    String? category,
    CancelToken? cancelToken,
    int pageSize = 20,
  }) async {
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

  /// Search news articles based on the query.
  ///
  /// [page] specifies the page number for pagination.
  /// [query] specifies the search term.
  /// [sortBy] specifies the sorting criteria.
  /// [cancelToken] allows canceling the request if necessary.
  Future<List<Articles>> searchNews({
    int page = 1,
    String query = 'news',
    String sortBy = 'publishedAt',
    CancelToken? cancelToken,
  }) async {
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
      throw Exception('Failed to load search results: $e');
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
      link.close();
    });
  });

  // Cancel the timer if the provider is resumed.
  ref.onResume(() {
    timer?.cancel();
  });

  // Fetch data based on the query or top headlines.
  if (query.isNotEmpty) {
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


// import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:news_app/src/core/models/articles.dart';
// import 'package:news_app/src/core/models/news_api_response.dart';
// import 'package:news_app/src/core/utils/constants.dart';
// import 'package:news_app/src/core/utils/dio_provider.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'news_repository.g.dart';

// typedef NewsQueryData = ({
//   int page,
//   String query,
//   String? sortBy,
//   String? category
// });

// class NewsRepository {
//   NewsRepository({required this.client, required this.apiKey});
//   final Dio client;
//   final String apiKey;
//   Future<List<Articles>> fetchTopHeadlines(
//       {int page = 1, CancelToken? cancelToken}) async {
//     final uri = Uri(
//       scheme: 'https',
//       host: 'newsapi.org',
//       path: '/v2/top-headlines',
//       queryParameters: {
//         'country': 'us',
//         'apiKey': apiKey,
//         'page': '$page',
//         'language': 'en',
//       },
//     );

//     final response = await client.getUri(uri, cancelToken: cancelToken);
//     final jsonResponse = response.data;
//     if (jsonResponse['status'] == 'ok' && jsonResponse['totalResults'] > 0) {
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
//     // return data;
//     // return NewsApiResponse.fromJson(response.data);
//   }

//   Future<List<Articles>> searchNews(
//       {required NewsQueryData queryData, CancelToken? cancelToken}) async {
//     final uri = Uri(
//       scheme: 'https',
//       host: 'newsapi.org',
//       path: '/v2/everything',
//       queryParameters: {
//         'api_key': apiKey,
//         'page': '${queryData.page}',
//         'q': 'Sports',
//       },
//     );

//     final response = await client.get(uri.toString(), cancelToken: cancelToken);
//     final jsonResponse = response.data;
//     if (jsonResponse['status'] == 'ok' && jsonResponse['totalResults'] > 0) {
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
//     // final response = await dio.getUri(uri, cancelToken: cancelToken);
//     // print("searchResponse: $response");
//     // return NewsApiResponse.fromJson(response.data);
//   }

//   // Future<NewsApiResponse> searchNewsByCategory(
//   //     {required NewsQueryData queryData, CancelToken? cancelToken}) async {
//   //   final uri = Uri(
//   //     scheme: 'https',
//   //     host: 'newsapi.org',
//   //     path: '/v2/top-headlines',
//   //     queryParameters: {
//   //       'api_key': apiKey,
//   //       'page': '${queryData.page}',
//   //       'sortBy': queryData.sortBy ?? 'publishedAt',
//   //     },
//   //   );
//   //   final response = await client.getUri(uri, cancelToken: cancelToken);
//   //   print("searchCatResponse: $response");
//   //   return NewsApiResponse.fromJson(response.data);
//   // }
// }

// @riverpod
// NewsRepository newsRepository(NewsRepositoryRef ref) => NewsRepository(
//       client: ref.watch(dioProvider),
//       apiKey: API_KEY,
//     );

// // class AbortedException implements Exception {}

// /// Provider to fetch paginated news data
// @riverpod
// Future<List<Articles>> fetchNews(
//   FetchNewsRef ref, {
//   required NewsQueryData queryData,
// }) async {
//   final newsRepo = ref.watch(newsRepositoryProvider);
//   // See this for how the timeout is implemented:
//   // Cancel the page request if the UI no longer needs it.
//   // This happens if the user scrolls very fast or if we type a different search term.
//   final cancelToken = CancelToken();
//   // When a page is no-longer used, keep it in the cache.
//   final link = ref.keepAlive();
//   // a timer to be used by the callbacks below
//   Timer? timer;
//   // When the provider is destroyed, cancel the http request and the timer
//   ref.onDispose(() {
//     cancelToken.cancel();
//     timer?.cancel();
//   });
//   // When the last listener is removed, start a timer to dispose the cached data
//   ref.onCancel(() {
//     // start a 30 second timer
//     timer = Timer(const Duration(seconds: 30), () {
//       // dispose on timeout
//       link.close();
//     });
//   });
//   // If the provider is listened again after it was paused, cancel the timer
//   ref.onResume(() {
//     timer?.cancel();
//   });
//   // if (queryData.query.isEmpty) {
//   // fetch top headlines
//   // return newsRepo.fetchTopHeadlines(
//   //   page: queryData.page,
//   //   cancelToken: cancelToken,
//   // );
//   //  ----------------return newsRepo.search
//   return newsRepo.searchNews(
//     queryData: queryData,
//     cancelToken: cancelToken,
//   );
//   // }
//   // else if (queryData.category != null) {
//   //   // fetch top headlines by category
//   //   return newsRepo.searchNewsByCategory(
//   //     queryData: queryData,
//   //     cancelToken: cancelToken,
//   //   );
//   // } else {
//   //   // use default search for everything
//   //   return newsRepo.searchNews(
//   //     queryData: queryData,
//   //     cancelToken: cancelToken,
//   //   );
//   // }
// }