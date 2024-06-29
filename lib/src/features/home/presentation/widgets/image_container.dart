import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  const ImageContainer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        //TODO:Fix the image loading issue
        child: CachedNetworkImage(
          imageUrl:
              "https://images.unsplash.com/photo-1680634658502-78e57b1eec50?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDQxfEUtLV9wbklpckc0fHxlbnwwfHx8fHw%3D",
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.white24,
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey,
            child: const Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
