import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/network/internet_service.dart';
import 'package:news_app/src/core/utils/utils.dart';

class ScaffoldWithConnectionChecker extends ConsumerStatefulWidget {
  const ScaffoldWithConnectionChecker({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<ScaffoldWithConnectionChecker> createState() =>
      _ScaffoldWithConnectionCheckerState();
}

class _ScaffoldWithConnectionCheckerState
    extends ConsumerState<ScaffoldWithConnectionChecker> {
  var buildNo = 0;
  bool? previouslyConnected;

  @override
  Widget build(BuildContext context) {
    final isConnected = ref.watch(connectivityNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {});

    print('Widget is online rebuild: ${buildNo++}');
    return widget.child;
  }
}
