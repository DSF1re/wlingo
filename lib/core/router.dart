import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wlingo/core/routes.dart';
import 'package:wlingo/features/auth/presentation/auth_screen.dart';
import 'package:wlingo/features/onboarding/presentation/onboarding_screen.dart';
import 'package:wlingo/features/register/presentation/reg_screen.dart';
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
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
});
