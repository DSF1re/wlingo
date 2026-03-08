import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/auth/domain/providers/current_user_provider.dart';
import 'package:wlingo/features/profile/domain/providers/history_provider.dart';
import 'package:wlingo/features/profile/domain/providers/rating_provider.dart';
import 'package:wlingo/features/profile/presentation/widgets/error_placeholder.dart';
import 'package:wlingo/features/profile/presentation/widgets/history.dart';
import 'package:wlingo/features/profile/presentation/widgets/profile_header.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    final userAsync = ref.watch(currentUserProvider);

    final refreshAll = useCallback(() async {
      ref.invalidate(currentUserProvider);
      userAsync.value?.fold((_) => null, (user) {
        if (user != null) {
          ref.invalidate(userRatingProvider(user.id));
          ref.invalidate(userHistoryProvider(user.id));
        }
      });
    }, [userAsync.value]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.profile,
          style: ThemeTextStyles.title3SemiBold(isDark: isDark),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.go(Routes.home),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [AppbarActions(isDark: isDark)],
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => ErrorPlaceholder(
          message: '${loc.error}: $err',
          onRetry: () => ref.invalidate(currentUserProvider),
        ),
        data: (either) => either.fold(
          (failure) => ErrorPlaceholder(
            message: failure.toLocalizedMessage(loc),
            onRetry: () => ref.invalidate(currentUserProvider),
          ),
          (user) {
            if (user == null) return Center(child: Text(loc.usr_not_found));

            return RefreshIndicator(
              onRefresh: refreshAll,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  ProfileHeaderSection(user: user, isDark: isDark, loc: loc),
                  HistorySection(userId: user.id, isDark: isDark, loc: loc),
                  const SliverToBoxAdapter(child: SizedBox(height: 40)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
