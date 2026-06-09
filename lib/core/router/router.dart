import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/features/admin/presentation/user_management_screen.dart';
import 'package:wlingo/features/auth/presentation/auth_screen.dart';
import 'package:wlingo/features/bookview/presentation/book_screen.dart';
import 'package:wlingo/features/bookview/presentation/pdf_view.dart';
import 'package:wlingo/features/home/presentation/home_screen.dart';
import 'package:wlingo/features/main/presentation/main_layout.dart';
import 'package:wlingo/features/onboarding/presentation/onboarding_screen.dart';
import 'package:wlingo/features/profile/presentation/profile_screen.dart';
import 'package:wlingo/features/auth/presentation/reg_screen.dart';
import 'package:wlingo/features/splash/presentation/splash_screen.dart';
import 'package:wlingo/features/word_practice/presentation/audition_game.dart';
import 'package:wlingo/features/word_practice/presentation/level_game_screen.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/features/word_practice/presentation/pronounce_game.dart';
import 'package:wlingo/widgets/navigation_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/features/ai_chat/presentation/ai_chat_screen.dart';
import 'package:wlingo/features/vocabulary/presentation/vocabulary_list_screen.dart';
import 'package:wlingo/features/auth/presentation/providers/current_user_provider.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
  final prefs = ref.read(sharedPrefsProvider);
  return GoRouter(
    initialLocation: prefs.getBool('onboarding_completed') == true
        ? (Supabase.instance.client.auth.currentSession != null
              ? Routes.home
              : Routes.login)
        : Routes.splash,
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final onboardingCompleted =
          prefs.getBool('onboarding_completed') ?? false;

      if (!onboardingCompleted &&
          state.uri.path != Routes.splash &&
          state.uri.path != Routes.onboarding) {
        return Routes.splash;
      }

      final loggedIn = session != null;
      final isLoggingIn =
          state.uri.path == Routes.login || state.uri.path == Routes.register;

      if (!loggedIn &&
          !isLoggingIn &&
          state.uri.path != Routes.splash &&
          state.uri.path != Routes.onboarding) {
        return Routes.login;
      }
      if (loggedIn && isLoggingIn) {
        return Routes.home;
      }

      return null;
    },
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
        path: Routes.auditionGame,
        builder: (context, state) => const AuditionGameScreen(),
      ),
      GoRoute(
        path: Routes.pronounceGame,
        builder: (context, state) => const PronunciationGameScreen(),
      ),
      GoRoute(
        path: Routes.levelGame,
        builder: (context, state) => const LevelGameScreen(),
      ),
      GoRoute(
        path: Routes.pdf,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';
          final loc = AppLocalizations.of(context)!;
          final title = state.uri.queryParameters['title'] ?? loc.pdf_title;
          final bookId = state.uri.queryParameters['bookId'] ?? '0';

          return PdfViewerScreen(url: url, title: title, bookId: bookId);
        },
      ),
      GoRoute(
        path: Routes.aiChat,
        builder: (context, state) => const AiChatScreen(),
      ),
      GoRoute(
        path: Routes.adminUsers,
        builder: (context, state) => const AdminUsersScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => Consumer(
          builder: (context, ref, _) {
            final userAsync = ref.watch(currentUserProvider);
            final isAdmin = userAsync.maybeWhen(
              data: (result) =>
                  result.fold((_) => false, (u) => u?.isAdmin ?? false),
              orElse: () => false,
            );

            return MainLayout(
              bnb: BottomNavBar(
                currentIndex: _calculateSelectedIndex(state.uri.path, isAdmin),
                onTap: (index) {
                  final paths = [
                    Routes.home,
                    Routes.books,
                    if (!isAdmin) Routes.vocabulary,
                    Routes.profile,
                  ];
                  if (index < paths.length) {
                    context.go(paths[index]);
                  }
                },
              ),
              child: child,
            );
          },
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
          GoRoute(
            path: Routes.vocabulary,
            redirect: (context, state) async {
              final container = ProviderScope.containerOf(context);
              final userResult = await container.read(
                currentUserProvider.future,
              );
              final isAdmin = userResult.fold(
                (_) => false,
                (u) => u?.isAdmin ?? false,
              );
              if (isAdmin) return Routes.home;
              return null;
            },
            builder: (context, state) => const VocabularyListScreen(),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
});

int _calculateSelectedIndex(String location, bool isAdmin) {
  if (location.startsWith(Routes.books)) return 1;
  if (location.startsWith(Routes.vocabulary)) return isAdmin ? 0 : 2;
  if (location.startsWith(Routes.profile)) return isAdmin ? 2 : 3;
  return 0;
}
