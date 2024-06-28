import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text('Onboarding Screen'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Icon(Icons.arrow_forward),
        ));
  }
}
