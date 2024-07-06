import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/localization/extensions.dart';
import 'package:shimmer/shimmer.dart';

class NewsListImage extends StatelessWidget {
  const NewsListImage({super.key, this.imageUrl, required this.imageWidth});
  final String? imageUrl;

  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    final cacheWidth = imageWidth * 3;
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          height: imageWidth,
          width: imageWidth,
          memCacheWidth: cacheWidth.cacheSize(context),
          placeholder: (_, __) => Shimmer.fromColors(
            baseColor: Colors.black26,
            highlightColor: Colors.black12,
            child: Container(
              width: imageWidth,
              height: imageWidth,
              color: Colors.black,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: imageWidth,
            height: imageWidth,
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image_outlined,
                size: 40, color: Colors.red),
          ),
        ),
      );
    }
    return const Placeholder(
      color: Colors.black87,
    );
  }
}
