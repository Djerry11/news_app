import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/features/explore/data/news_query_notifier.dart';
import 'package:news_app/src/features/explore/presentation/widgets/new_search_filter.dart';
import 'package:news_app/src/localization/extensions.dart';

class NewsSearchBar extends ConsumerStatefulWidget {
  const NewsSearchBar({super.key, required this.isConnected});
  final bool isConnected;
  @override
  ConsumerState<NewsSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<NewsSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const Icon(CupertinoIcons.search, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Search '.hardcoded,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey),
                        ),
                        onEditingComplete: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            ref
                                .read(newsQueryNotifierProvider.notifier)
                                .setQuery(text);
                          }
                        }),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      showFilterSheet(context, ref,
                          maxWidth: MediaQuery.of(context).size.width);
                    },
                    icon: const Icon(CupertinoIcons.slider_horizontal_3,
                        color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
