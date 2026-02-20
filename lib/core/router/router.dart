import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/auth/presentation/auth_screen.dart';
import 'package:wlingo/features/bookview/presentation/screens/book_screen.dart';
import 'package:wlingo/features/bookview/presentation/screens/pdf_view.dart';
import 'package:wlingo/features/home/presentation/home_screen.dart';
import 'package:wlingo/features/main/presentation/main_layout.dart';
import 'package:wlingo/features/onboarding/presentation/onboarding_screen.dart';
import 'package:wlingo/features/register/presentation/reg_screen.dart';
import 'package:wlingo/features/splash/presentation/splash_screen.dart';
import 'package:wlingo/main.dart';
import 'package:wlingo/widgets/navigation_bar.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: shared.getBool('onboarding_completed') == true
        ? Routes.login
        : Routes.splash,
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
      GoRoute(
        path: Routes.pdf,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';
          final title = state.uri.queryParameters['title'] ?? 'PDF';
          final bookId = state.uri.queryParameters['bookId'] ?? '0';

          return PdfViewerScreen(url: url, title: title, bookId: bookId);
        },
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(
          bnb: BottomNavBar(
            currentIndex: _calculateSelectedIndex(state.uri.path),
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/books');
                  break;
                case 2:
                  break;
              }
            },
          ),
          child: child,
        ),
        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: Routes.books,
            builder: (context, state) => const BooksScreen(),
          ),
        ],
      ),
    ],
  );
});

int _calculateSelectedIndex(String location) {
  if (location.startsWith('/books')) return 1;
  if (location.startsWith('/profile')) return 2;
  return 0;
}
