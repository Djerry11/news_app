import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/localization/extensions.dart';
import 'package:news_app/src/routes/app_routes.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsItem extends StatelessWidget {
  const TrendingNewsItem({
    super.key,
    required this.article,
    required this.maxWidth,
  });
  final double maxWidth;
  final Articles article;

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage;
    final trendingTitle = article.title;
    final trendingSource = article.source!.name;
    final cacheWidth = maxWidth;

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoute.webViewArticle.name,
          pathParameters: {
            'id': article.source!.name!,
          },
          extra: article,
        );
      },
      child: Container(
        width: maxWidth * 0.85,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 5),
              blurRadius: 10,
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                memCacheWidth: cacheWidth.cacheSize(context),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.white,
                  child: const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.1, 0.3],
                  colors: [
                    Colors.black.withOpacity(1.0),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$trendingSource",
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      trendingTitle!,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Text(
                    //   trendingDescription!,
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: const TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.white70,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: 10,
            //   right: 10,
            //   child: FavoriteButton(article: article),
            // ),
          ],
        ),
      ),
    );
  }
}
