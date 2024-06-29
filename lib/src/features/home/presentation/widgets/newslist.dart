import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/common/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/core/network/news_repository.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/features/home/presentation/widgets/news_tile.dart';
import 'package:news_app/src/providers/news_provider.dart';
import 'package:news_app/src/routes/app_routes.dart';

// import 'news_tile.dart';s

class NewsList extends ConsumerWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider);
    // final articlesAsyncValue = ref.watch(fetchNewsProvider(
    //   queryData: (
    //     category: 'Sports',
    //     query: '',
    //     page: 1,
    //     sortBy: null,
    //   ),
    // ));
    return articlesAsync.when(
      data: (response) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: response.length,
          itemBuilder: (context, index) {
            final article = response[index];
            return SizedBox(
              height: 120,
              width: double.infinity,
              child: NewsListTile(
                article: article,
                onPressed: () => context.pushNamed(
                  AppRoute.webViewArticle.name,
                  pathParameters: {
                    'id': article.source!.name!,
                  },
                  extra: article,
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
