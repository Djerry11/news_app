import 'package:go_router/go_router.dart';
import 'package:news_app/src/features/onboarding/presentation/onboarding_screen.dart';
import '../features/home/presentation/home_page.dart';
import '../features/home/presentation/article_detail_page.dart';
import '../features/favorites/presentation/favorites_page.dart';

class AppRoutes {
  late final GoRouter _router;
  AppRoutes()
      : _router = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const OnboardingScreen(),
              routes: [
                GoRoute(
                  path: 'home',
                  builder: (context, state) => const HomePage(),
                  routes: [
                    GoRoute(
                      path: 'article/:id',
                      builder: (context, state) => ArticleDetailPage(
                          articleId: state.pathParameters['id']!),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'favorites',
                  builder: (context, state) => const FavoritesPage(),
                ),
              ],
            ),
          ],
        );

  GoRouter get router => _router;
}
