import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/src/common_widgets/test.dart';
import 'package:news_app/src/core/models/articles.dart';
import 'package:news_app/src/features/explore/presentation/news_search_screen.dart';
import 'package:news_app/src/features/favorites/presentation/favorite_page.dart';
import 'package:news_app/src/features/onboarding/presentation/onboarding_page.dart';
import 'package:news_app/src/common_widgets/webview_article.dart';
import 'package:news_app/src/routes/scaff_nav_bar.dart';

import '../features/home/presentation/home_page.dart';

enum AppRoute {
  home,
  discover,
  favorites,
  profile,
  webViewArticle,
}

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
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      // // Onboarding Page ;; First page to be shown
      // GoRoute(
      //   path: '/',
      //   name: 'root',
      //   builder: (context, state) => const ScaffoldWithConnectionChecker(
      //     child: OnboardingPage(),
      //   ),
      // ),
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
                name: AppRoute.home.name,
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
                name: AppRoute.discover.name,
                builder: (context, state) => const NewsSearchScreen(),
              ),
            ],
          ),
          // Favorites Branch
          StatefulShellBranch(
            navigatorKey: _favNavigatorKey,
            routes: [
              GoRoute(
                path: '/favorites',
                name: AppRoute.favorites.name,
                builder: (context, state) => const FavoritePage(),
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: AppRoute.profile.name,
                builder: (context, state) => const TestPage(),
              ),
            ],
          ),
        ],
      ),

      //Web view Article details :: open the article in web view
      GoRoute(
        path: '/webViewArticle/:id',
        name: AppRoute.webViewArticle.name,
        builder: (context, state) {
          final article = state.extra as Articles?;
          if (article == null) {
            return const Scaffold(
              body: Center(
                child: Text('Article data not found'),
              ),
            );
          }
          return WebViewArticle(article: article);
        },
      ),
    ],
  );
}
