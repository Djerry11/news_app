import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/providers/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewArticle extends StatefulWidget {
  const WebViewArticle({super.key, required this.article});
  final Articles article;

  @override
  State<WebViewArticle> createState() => _WebViewArticleState();
}

class _WebViewArticleState extends State<WebViewArticle> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  void _openBrowser() async {
    final url = widget.article.url!;
    final webUri = Uri.parse(url);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open in Browser'),
          content: const Text('Do you want to open the URL in the browser?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (await canLaunchUrl(webUri)) {
                  await launchUrl(webUri);
                } else {
                  throw 'Could not launch $webUri';
                }
                // ignore: use_build_context_synchronously
                context.pop();
              },
              child: const Text('Open'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(Uri.parse(widget.article.url!));
  }

  @override
  Widget build(BuildContext context) {
    final source = widget.article.source!.name;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          source!,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
        ),
        actions: [
          Consumer(builder: (context, ref, child) {
            final bookmarkNotifier = ref.read(bookmarkProvider.notifier);
            final isBookmarked = ref
                .watch(bookmarkProvider)
                .any((a) => a.url == widget.article.url);

            return IconButton(
              icon: isBookmarked
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_outline),
              color: isBookmarked ? Colors.red : Colors.green,
              onPressed: () {
                isBookmarked
                    ? bookmarkNotifier.removeBookmark(widget.article)
                    : bookmarkNotifier.addBookmark(widget.article);
              },
            );
          }),
          const SizedBox(
            width: 3,
          ),
          IconButton(
            onPressed: _openBrowser,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100,
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
          ],
        ),
      ),
    );
  }
}
