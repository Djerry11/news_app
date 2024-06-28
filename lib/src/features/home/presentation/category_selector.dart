import 'package:flutter/material.dart';

final List<String> categories = [
  'Politics',
  'Sports',
  'Tech',
  'World news',
  'Economy',
];

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Chip(
              label: Text(categories[index]),
            ),
          );
        },
      ),
    );
  }
}
