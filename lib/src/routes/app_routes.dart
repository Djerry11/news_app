import 'package:go_router/go_router.dart';
import '../features/home/presentation/home_page.dart';
import '../features/home/presentation/article_detail_page.dart';
import '../features/favorites/presentation/favorites_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/article/:id',
      builder: (context, state) =>
          ArticleDetailPage(articleId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
  ],
);
