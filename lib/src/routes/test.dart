import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/models/news_api_response.dart';
import 'package:news_app/src/core/network/news_repository.dart';
import 'package:news_app/src/core/utils/constants.dart';
import 'package:news_app/src/features/home/presentation/widgets/news_tile.dart';
import 'package:news_app/src/routes/news_tile_shimmer.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    final webResposne = NewsRepository(
      client: Dio(),
      apiKey: API_KEY,
    );
    final getHeadlines = webResposne.fetchTopHeadlines(page: 1);

    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            print('getHeadlines: $getHeadlines');
          },
          child: const Text('Test'),
        ),
      ),
    );
  }
}

// class MoviesListView extends ConsumerWidget {
//   const MoviesListView({super.key});

//   static const pageSize = 20;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         final page = index ~/ pageSize + 1;
//         final indexInPage = index % pageSize;
//         // use the fact that this is an infinite list to fetch a new page
//         // as soon as the index exceeds the page size
//         // Note that ref.watch is called for up to pageSize items
//         // with the same page and query arguments (but this is ok since data is cached)
//         final AsyncValue<NewsApiResponse> responseAsync =
//             ref.watch(fetch(page));
//         return responseAsync.when(
//           error: (err, stack) => Text(err.toString()),
//           loading: () => const NewsTileShimmer(),
//           data: (response) {
//             // This condition only happens if a null itemCount is given
//             if (indexInPage >= response.totalResults!) {
//               return null;
//             }
//             final article = response.results[indexInPage];
//             return NewsTile(
//               article: ,
//             );
//           },
//         );
//       },
//     );
//   }
// }
