import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/src/core/network/news_repository.dart';
import 'package:news_app/src/features/discover/presentation/search_bar.dart';
import 'package:news_app/src/features/discover/presentation/news_query_notifier.dart';

import 'package:news_app/src/features/home/presentation/widgets/news_tile.dart';
import 'package:news_app/src/routes/news_tile_shimmer.dart';

class NewsSearchScreen extends ConsumerWidget {
  const NewsSearchScreen({super.key});

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(newsQueryNotifierProvider);
    String? category;
    String? sortBy = 'publishedAt';
    // * get the first page so we can retrieve the total number of results
    final responseAsync = ref.watch(
      fetchNewsProvider(queryData: (
        page: 1,
        query: query,
        category: category,
        sortBy: sortBy
      )),
    );
    final totalResults = responseAsync.valueOrNull?.totalResults;
    return Scaffold(
      appBar: AppBar(title: const Text('World News')),
      body: Column(
        children: [
          const NewsSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // dispose all the pages previously fetched. Next read will refresh them
                ref.invalidate(fetchNewsProvider);
                // keep showing the progress indicator until the first page is fetched
                try {
                  await ref.read(
                    fetchNewsProvider(queryData: (
                      page: 1,
                      query: query,
                      category: category,
                      sortBy: sortBy
                    )).future,
                  );
                } catch (e) {
                  // fail silently as the provider error state is handled inside the ListView
                }
              },
              child: ListView.builder(
                // use a different key for each querydata, ensuring the scrollposition is reset when the querydata and results change
                key: ValueKey(query),
                // * pass the itemCount explicitly to prevent unnecessary renders during overscroll
                itemCount: totalResults,
                itemBuilder: (context, index) {
                  final page = index ~/ pageSize + 1;
                  final indexInPage = index % pageSize;
                  // use the fact that this is an infinite list to fetch a new page
                  // as soon as the index exceeds the page size
                  // Note that ref.watch is called for up to pageSize items
                  // with the same page and querydata arguments (but this is ok since data is cached)
                  final responseAsync = ref.watch(
                    fetchNewsProvider(
                      queryData: (
                        page: page,
                        query: query,
                        category: category,
                        sortBy: sortBy
                      ),
                    ),
                  );
                  return responseAsync.when(
                    error: (err, stack) => NewsListTileError(
                      query: query,
                      page: page,
                      indexInPage: indexInPage,
                      error: err.toString(),
                      isLoading: responseAsync.isLoading,
                    ),
                    loading: () => const NewsTileShimmer(),
                    data: (response) {
                      //log('index: $index, page: $page, indexInPage: $indexInPage, len: ${response.results.length}');
                      // * This condition only happens if a null itemCount is given
                      if (indexInPage >= response.articles!.length) {
                        return null;
                      }
                      final article = response.articles![indexInPage];
                      return NewsTile(article: article);
                      //  NewsListTile(
                      //   news: news,
                      //   debugIndex: index + 1,
                      //   onPressed: () => context.goNamed(
                      //     AppRoute.news.name,
                      //     pathParameters: {'id': news.id.toString()},
                      //     extra: news,
                      //   ),
                      // );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsListTileError extends ConsumerWidget {
  const NewsListTileError({
    super.key,
    required this.query,
    required this.page,
    required this.indexInPage,
    required this.isLoading,
    required this.error,
  });
  final String query;
  final int page;
  final int indexInPage;
  final bool isLoading;
  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Only show error on the first item of the page
    return indexInPage == 0
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(error),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          // invalidate the provider for the errored page
                          ref.invalidate(fetchNewsProvider);

                          // wait until the page is loaded again
                          return ref.read(
                            fetchNewsProvider(queryData: (
                              page: page,
                              query: query,
                              category: null,
                              sortBy: null,
                            )).future,
                          );

                          // return ref.read(
                          //   fetch: (page: page, querydata: querydata))
                          //       .future,
                          // );
                        },
                  child: const Text('Retry'),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
