import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_tile_shimmer.dart';
import 'package:news_app/src/common_widgets/no_internet_connection.dart';
import 'package:news_app/src/common_widgets/something_went_wrong.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/core/network/internet_service.dart';
import 'package:news_app/src/core/network/news_repository.dart';
import 'package:news_app/src/features/explore/presentation/search_bar.dart';
import 'package:news_app/src/features/explore/data/news_query_notifier.dart';
import 'package:news_app/src/routes/app_routes.dart';

class NewsSearchScreen extends ConsumerStatefulWidget {
  const NewsSearchScreen({super.key});
  //TODO: Add more robust pagination based on the total results from the API
  static const pageSize = 10;

  @override
  ConsumerState<NewsSearchScreen> createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends ConsumerState<NewsSearchScreen> {
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      ref.read(fetchNewsProvider(page: _currentPage + 1).future).then((_) {
        setState(() {
          _currentPage++;
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search News',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final query = ref.watch(newsQueryNotifierProvider);
          final responseAsync =
              ref.watch(fetchNewsProvider(page: _currentPage, query: query));
          final isOnline = ref.watch(connectivityNotifierProvider);
          return Column(
            children: [
              NewsSearchBar(
                isConnected: isOnline,
              ),
              Flexible(
                child: isOnline
                    ? showSearchContents(responseAsync)
                    : SingleChildScrollView(
                        child: NoInternetConnection(
                          onRefresh: () {
                            setState(() {
                              _currentPage = 1;
                            });
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget showSearchContents(AsyncValue<List<Articles>> responseAsync) {
    return RefreshIndicator(
      onRefresh: () async {
        // Reset the current page and invalidate the provider to refresh the data.
        setState(() {
          _currentPage = 1;
        });
        ref.invalidate(fetchNewsProvider);
        try {
          await ref.read(fetchNewsProvider(page: 1).future);
        } catch (e) {
          // Handle error silently as the provider error state is managed inside the ListView.
        }
      },
      child: responseAsync.when(
        // Show shimmer loading effect while fetching data
        loading: () => ListView.builder(
          controller: _scrollController,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const SizedBox(
              height: 120,
              width: double.infinity,
              child: NewsTileShimmer(),
            );
          },
        ),
        // Show error message if the request fails
        error: (err, stack) => const SingleChildScrollView(
          child: SomethingWentWrong(
              imagePath: 'assets/images/oops.png',
              message: 'No Related News Found'),
        ),

        //showing search data
        data: (articles) {
          return articles.isEmpty

              /// Show no related news found message if no data is returned
              ? const SingleChildScrollView(
                  child: SomethingWentWrong(
                    imagePath: 'assets/images/oops.png',
                    message: 'No Related News Found',
                  ),
                )

              /// Show the list of articles
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return NewsListTile(
                      article: article,
                      debugIndex: index + 1,
                      onPressed: () => context.pushNamed(
                        AppRoute.webViewArticle.name,
                        pathParameters: {'id': article.source!.name.toString()},
                        extra: article,
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
