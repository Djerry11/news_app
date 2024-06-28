import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/features/onboarding/presentation/onboarding_page.dart';
import 'package:news_app/src/routes/scaff_nav_bar.dart';
import '../features/home/presentation/home_page.dart';
import '../features/home/presentation/article_detail_page.dart';
import '../features/favorites/presentation/favorites_page.dart';

class AppRoutes {
  AppRoutes._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _favNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'favKey');
  static final _homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homKey');
  static final _catNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homKey');
  static final _profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homKey');

  static final router = GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: '/',
        builder: (context, state) => const OnboardingPage(),
      ),

      // Nested Navigation for Home and Favorites
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          // Home
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          // Favorites Branch
          StatefulShellBranch(
            navigatorKey: _catNavigatorKey,
            routes: [
              GoRoute(
                path: '/category',
                name: 'category',
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          // Favorites Branch
          StatefulShellBranch(
            navigatorKey: _favNavigatorKey,
            routes: [
              GoRoute(
                path: '/favorites',
                name: 'favorites',
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          ),
          // Favorites Branch
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const FavoritesPage(),
              ),
            ],
          )
        ],
      ),

      //Article details
      GoRoute(
        path: '/article/:articleId',
        name: 'articleDetail',
        builder: (context, state) {
          final id = state.pathParameters['articleId']!;
          return ArticleDetailPage(articleId: id);
        },
      ),
    ],
  );
}
