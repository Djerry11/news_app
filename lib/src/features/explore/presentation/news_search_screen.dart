import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_tile_shimmer.dart';
import 'package:news_app/src/common_widgets/no_internet_connection.dart';
import 'package:news_app/src/common_widgets/something_went_wrong.dart';
import 'package:news_app/src/core/network/internet_service.dart';
import 'package:news_app/src/core/network/news_repository.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/features/explore/presentation/widgets/search_bar.dart';
import 'package:news_app/src/features/explore/data/news_query_notifier.dart';
import 'package:news_app/src/localization/extensions.dart';
import 'package:news_app/src/routes/app_routes.dart';

class NewsSearchScreen extends ConsumerStatefulWidget {
  const NewsSearchScreen({super.key});
  //TODO: Add more robust pagination based on the total results from the API
  static const pageSize = 20;

  @override
  ConsumerState<NewsSearchScreen> createState() => _NewsSearchScreenState();
}

class _NewsSearchScreenState extends ConsumerState<NewsSearchScreen> {
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  var selectedCategoryIndex = 0;
  var selectedCategory = NewsCategory.general;
  var selectedQueryCategory = 'general';
  final TextEditingController _queryController = TextEditingController();

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

  void onSelectCategory(NewsCategory category) {
    setState(() {
      selectedCategory = category;
      selectedQueryCategory = category.name;
      // print('Selected Category: $selectedCategory');
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _queryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final query = ref.watch(newsQueryNotifierProvider);

            final isOnline = ref.watch(connectivityNotifierProvider);
            final isSearchTextEmpty = query.isEmpty;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Discover\n'.hardcoded,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontSize: 30,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        TextSpan(
                          text: 'News from all around the world'.hardcoded,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                NewsSearchBar(
                  queryController: _queryController,
                  isConnected: isOnline,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //  Catergory Chips -- General, Business, Health, Science, Sports, Technology
                    children: NewsCategory.values.map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Text(
                            category.name == 'general'
                                ? 'All'
                                : category.name.toCapitalized(),
                          ),
                          showCheckmark: false,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(19),
                          ),
                          labelStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: selectedCategory == category
                                        ? Colors.white
                                        : Colors.black54,
                                  ),
                          selected: selectedCategory == category,
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.grey.shade100,
                          onSelected: (selected) {
                            onSelectCategory(category);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: isSearchTextEmpty
                      ? SingleChildScrollView(
                          child: Center(
                            child: Lottie.asset(
                              'assets/animations/search_anim.json',
                              height: 200,
                            ),
                          ),
                          // SomethingWentWrong(
                          //   imagePath: 'assets/images/oops2.png',
                          //   message: 'Search for news ...',
                          //   showOops: false,
                          // ),
                        )
                      : isOnline
                          ? showSearchContents()
                          : SingleChildScrollView(
                              child: NoInternetConnection(
                                onRefresh: () async {
                                  onRefresh();
                                },
                              ),
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget showSearchContents() {
    final responseAsync = ref.watch(
        fetchNewsProvider(page: _currentPage, category: selectedQueryCategory));
    return RefreshIndicator(
      onRefresh: () async {
        // Reset the current page and invalidate the provider to refresh the data.
        await onRefresh();
      },
      child: responseAsync.when(
        // Show shimmer loading effect while fetching data
        loading: () => ListView.builder(
          controller: _scrollController,
          itemCount: 3,
          itemBuilder: (context, index) {
            return const SizedBox(
              height: 120,
              width: double.infinity,
              child: NewsTileShimmer(),
            );
          },
        ),
        // Show error message if the request fails
        error: (err, stack) {
          // print('Error: $err');
          return SingleChildScrollView(
            child: err.toString().contains('Failed to load search results')
                ? const SomethingWentWrong(
                    imagePath: 'assets/images/oops.png',
                    message: 'No Related News Found',
                  )
                : SomethingWentWrong(
                    onRefresh: () async {
                      onRefresh();
                    },
                  ),
          );
        },
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

  Future<void> onRefresh() async {
    //TODO:Change Onrefresh with animations
    // Reset the current page and invalidate the provider to refresh the data.
    setState(() {
      _queryController.clear();
      _currentPage = 1;
    });

    ref.invalidate(fetchNewsProvider);

    try {
      await ref.read(
          fetchNewsProvider(page: _currentPage, category: selectedQueryCategory)
              .future);
    } catch (e) {
      // Handle error silently as the provider error state is managed inside the ListView.
    }
  }
}
