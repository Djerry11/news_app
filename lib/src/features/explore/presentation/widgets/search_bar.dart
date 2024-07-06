import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/features/explore/data/news_query_notifier.dart';
import 'package:news_app/src/features/explore/presentation/widgets/new_search_filter.dart';
import 'package:news_app/src/localization/extensions.dart';

class NewsSearchBar extends ConsumerStatefulWidget {
  const NewsSearchBar(
      {super.key, required this.isConnected, required this.queryController});
  final bool isConnected;
  final TextEditingController queryController;

  @override
  ConsumerState<NewsSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<NewsSearchBar> {
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
                        controller: widget.queryController,
                        style: const TextStyle(color: Colors.black54),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Search '.hardcoded,
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey.shade400),
                        ),
                        onEditingComplete: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onChanged: (text) {
                          ref
                              .read(newsQueryNotifierProvider.notifier)
                              .setQuery(text);
                        }),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                      Colors.transparent,
                    )),
                    onPressed: () {
                      showFilterSheet(context, ref,
                          maxWidth: MediaQuery.of(context).size.width);
                    },
                    icon: Icon(CupertinoIcons.slider_horizontal_3,
                        color: Colors.grey.shade800)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
