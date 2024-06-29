import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsListImage extends StatelessWidget {
  const NewsListImage({super.key, this.imageUrl});
  final String? imageUrl;

  static const width = 80.0;
  static const height = 80.0;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl:
            'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bmV3c3xlbnwwfHwwfHx8MA%3D%3D',
        fit: BoxFit.cover,
        height: height,
        width: width,
        memCacheHeight: 100,
        memCacheWidth: 100,
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
          ),
        ),
      );
    }
    return const Placeholder(
      color: Colors.black87,
    );
  }
}
