import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/features/discover/presentation/news_query_notifier.dart';

class NewsSearchBar extends ConsumerStatefulWidget {
  const NewsSearchBar({super.key});

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
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: 'Search news',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                      ),
                      onEditingComplete: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (text) => ref
                          .read(newsQueryNotifierProvider.notifier)
                          .setQuery(text),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
