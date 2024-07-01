import 'package:flutter/material.dart';

class ShimmerImageWidget extends StatelessWidget {
  final String imagePath;

  const ShimmerImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        // child: CachedNetworkImage(
        //   imageUrl: imagePath,
        //   fit: BoxFit.cover,
        //   placeholder: (context, url) => Shimmer.fromColors(
        //     baseColor: Colors.grey.shade300,
        //     highlightColor: Colors.grey.shade100,
        //     child: Container(
        //       color: Colors.grey.shade300,
        //     ),
        //   ),
        //   errorWidget: (context, url, error) => const Icon(Icons.error),
        // ),
      ),
    );
  }
}
