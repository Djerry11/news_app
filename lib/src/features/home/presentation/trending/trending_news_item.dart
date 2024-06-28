import 'package:flutter/material.dart';

class TrendingNewsItem extends StatelessWidget {
  const TrendingNewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 170,
            width: double.maxFinite,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.asset(
                'assets/images/onboard3.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Thailand’s Economy is Slowing, and it Could Mean Trouble',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Al Jazeera',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '45 mins ago',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '7 minutes read',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
