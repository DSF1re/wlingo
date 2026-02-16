import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wlingo/core/routes.dart';
import 'package:wlingo/features/onboarding/onboarding_screen.dart';
import 'package:wlingo/features/splash/presentation/splash_screen.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
});
