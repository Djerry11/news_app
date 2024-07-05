import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_list_tile.dart';
import 'package:news_app/src/common_widgets/news_list_tile/news_tile_shimmer.dart';
import 'package:news_app/src/common_widgets/something_went_wrong.dart';
import 'package:news_app/src/core/theme/data/theme_provider.dart';
import 'package:news_app/src/dummy_article.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider.notifier);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('News App',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 24,
                )),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // const NewsListTile(article: dummyArticle),
          const Icon(Icons.home),

          const SizedBox(height: 10),
          Text(
            'Breaking News',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Today in Flutter development...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Stay tuned for more updates!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
