import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/common_widgets/something_went_wrong.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: Flexible(
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: const SingleChildScrollView(
              child: SomethingWentWrong(
                imagePath: 'assets/images/oops.png',
                message: 'No Related News Found',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
