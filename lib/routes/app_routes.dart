import 'package:go_router/go_router.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/detail_screen.dart';
import '../presentation/screens/form_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../domain/models/anime.dart';

class AppRoutes {
  static const home = '/';
  static const detail = '/detail';
  static const form = '/form';
  static const settings = '/settings';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(title: 'Animes World'),
      ),
      GoRoute(
        path: detail,
        builder: (context, state) {
          final anime = state.extra as Anime;
          return DetailScreen(anime: anime);
        },
      ),
      GoRoute(
        path: form,
        builder: (context, state) => const FormScreen(),
      ),
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
