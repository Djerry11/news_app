import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'animated_welcome_text.dart';
import 'shimmer_image_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<Map<String, String>> onboardingData = [
    {
      'image':
          'https://images.unsplash.com/photo-1523995462485-3d171b5c8fa9?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'description':
          'Get to know what\'s happening around the world faster than everyone.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1602303885393-4be251de62c4?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'description': 'Stay updated with the latest news and trends.',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1570179538662-faa5e38e9d8f?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D/',
      'description': 'Explore news from different categories and regions.',
    },
  ];

  int currentIndex = 0;

  void _nextPage() {
    setState(() {
      if (currentIndex < onboardingData.length - 1) {
        currentIndex++;
      } else {
        context.goNamed('home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const AnimatedWelcomeText(
              text: 'Welcome to News World',
            ), // Animated welcome text
            const SizedBox(height: 20),
            // Shimmer effect for onboarding image
            ShimmerImageWidget(
              imagePath: onboardingData[currentIndex]['image']!,
            ),
            const SizedBox(height: 20),
            // Onboarding message text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedWelcomeText(
                text: onboardingData[currentIndex]['description']!,
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                repeatForever: true,
                speed: 40,
              ),
            ),
            const Spacer(),
            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                TextButton(
                  onPressed: () {
                    context.goNamed('home');
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Spacer(flex: 5),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    iconColor: Colors.white,
                  ),
                  child: const Icon(Icons.arrow_forward),
                ),
                const Spacer(flex: 1),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
