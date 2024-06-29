import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/features/discover/presentation/discover_page.dart';
import 'package:news_app/src/features/onboarding/presentation/onboarding_page.dart';
import 'package:news_app/src/features/web_articles/presentation/webview_article.dart';
import 'package:news_app/src/routes/scaff_nav_bar.dart';
import '../features/home/presentation/home_page.dart';
import '../features/favorites/presentation/bookmark_page.dart';

class AppRoutes {
  AppRoutes._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _favNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'favKey');
  static final _homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeKey');
  static final _catNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'catKey');
  static final _profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profileKey');

  static final router = GoRouter(
    initialLocation: '/discover',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'onboarding',
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
          // Home Branch
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
          // Discover Branch
          StatefulShellBranch(
            navigatorKey: _catNavigatorKey,
            routes: [
              GoRoute(
                path: '/discover',
                name: 'discover',
                builder: (context, state) => const DiscoverPage(),
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
                builder: (context, state) => const BookmarkPage(),
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const BookmarkPage(),
              ),
            ],
          ),
        ],
      ),

      // Article details
      GoRoute(
        path: '/webViewArticle',
        name: 'webViewArticle',
        builder: (context, state) {
          final articleJson = state.uri.queryParameters['article'];
          if (articleJson == null) {
            return const Scaffold(
              body: Center(
                child: Text('Article data not found'),
              ),
            );
          }
          final jsonArticle = jsonDecode(articleJson);
          return WebViewArticle(article: Articles.fromJson(jsonArticle));
        },
      ),
    ],
  );
}
