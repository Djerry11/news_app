import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:news_app/src/common_widgets/news_list_tile/favorite_button.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/features/home/presentation/widgets/round_icon_button.dart';

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
  void dispose() {
    super.dispose();
  }

  void _openBrowser() async {
    final url = widget.article.url!;
    final webUri = Uri.parse(url);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Open in Browser',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),

          //  TextStyle(
          //   color: Colors.black,
          //   fontWeight: FontWeight.bold,
          //   fontSize: 20,
          // )),
          content: Text(
            'Do you want to open this in the browser?',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                // ignore: use_build_context_synchronously
                context.pop();
                if (await canLaunchUrl(webUri)) {
                  await launchUrl(webUri);
                } else {
                  throw 'Could not launch $webUri';
                }
              },
              child: const Text('Open', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final source = widget.article.source!.name;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundIconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icons.arrow_back_ios_rounded,
            iconColor: Colors.black87,
          ),
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
          IconButton(
            onPressed: _openBrowser,
            icon: const Icon(Icons.share),
          ),
          const SizedBox(
            width: 3,
          ),
          FavoriteButton(article: widget.article),
          const SizedBox(
            width: 3,
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
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
