import 'package:event_listing_app/features/auth/presentation/screens/login_screen.dart';
import 'package:event_listing_app/features/events/presentation/screens/event_screen.dart';
import 'package:event_listing_app/features/events/presentation/screens/web_view_screen.dart';
import 'package:event_listing_app/features/home/domain/entity/category_entity.dart';
import 'package:event_listing_app/features/home/presentation/screen/home_screen.dart';
import 'package:event_listing_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(
        path: '/events',
        builder: (context, state) {
          final category = state.extra as CategoryEntity?;
          return EventsScreen(category: category);
        },
      ),
      GoRoute(
        path: '/web-view',
        builder: (context, state) {
          final url = state.extra as String?;
          return WebViewPage(url: url!);
        },
      ),
    ],
  );
});
