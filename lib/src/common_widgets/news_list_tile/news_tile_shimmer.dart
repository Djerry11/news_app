import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsTileShimmer extends StatelessWidget {
  const NewsTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).shadowColor,
      highlightColor: Theme.of(context).highlightColor,
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(8),
                    )),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 60,
                        height: 10.0,
                        color: Colors.black38,
                        margin: const EdgeInsets.only(bottom: 8.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 15.0,
                        color: Colors.black38,
                        margin: const EdgeInsets.only(bottom: 8.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 15.0,
                        color: Colors.black38,
                        margin: const EdgeInsets.only(bottom: 10.0),
                      ),
                      Container(
                        width: 110,
                        height: 10.0,
                        color: Colors.black38,
                        margin: const EdgeInsets.only(bottom: 3.0),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 10.0,
                            color: Colors.black38,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Container(
                            width: 80,
                            height: 10.0,
                            color: Colors.black38,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Positioned(
            bottom: 7,
            right: 24,
            child: Icon(
              Icons.bookmark,
              color: Colors.black38,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
