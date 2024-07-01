import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/common_widgets/no_internet_connection.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/core/network/internet_service.dart';
import 'package:news_app/src/core/network/news_repository.dart';
import 'package:news_app/src/features/explore/presentation/search_bar.dart';
import 'package:news_app/src/features/explore/data/news_query_notifier.dart';
import 'package:news_app/src/routes/app_routes.dart';

class NewsSearchScreen extends ConsumerStatefulWidget {
  const NewsSearchScreen({super.key});
  //TOOD::Add more robust pagination based on the total results from the API
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
      )),
      body: Consumer(builder: (context, ref, child) {
        final query = ref.watch(newsQueryNotifierProvider);
        final responseAsync =
            ref.watch(fetchNewsProvider(page: _currentPage, query: query));
        final isOnline = ref.watch(connectivityNotifierProvider);
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NewsSearchBar(
              isConnected: isOnline,
            ),
            isOnline
                ? showSearchContents(responseAsync)
                : NoInternetConnection(
                    onRefresh: () {
                      setState(() {
                        _currentPage = 1;
                      });
                    },
                  ),
          ],
        );
      }),
    );
  }

  Expanded showSearchContents(AsyncValue<List<Articles>> responseAsync) {
    return Expanded(
      child: RefreshIndicator(
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
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => const Center(
              child: Text(
                  'Oops!,No matching articles found!\nPlease try another query!')),
          data: (articles) {
            return (articles.isEmpty)
                ? const Center(
                    child: Text('Oops!,No matching articles found! Error404'))
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
                          pathParameters: {
                            'id': article.source!.name.toString()
                          },
                          extra: article,
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
