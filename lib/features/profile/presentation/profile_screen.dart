import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/auth/domain/providers/current_user_provider.dart';
import 'package:wlingo/features/profile/domain/providers/history_provider.dart';
import 'package:wlingo/features/profile/domain/providers/rating_provider.dart';
import 'package:wlingo/features/profile/presentation/widgets/error_placeholder.dart';
import 'package:wlingo/features/profile/presentation/widgets/history_tile.dart';
import 'package:wlingo/features/profile/presentation/widgets/profile_card.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final userAsync = ref.watch(currentUserProvider);

    Future<void> refreshAll() async {
      ref.invalidate(currentUserProvider);
      final user = userAsync.value?.fold((_) => null, (u) => u);
      if (user != null) {
        ref.invalidate(userRatingProvider(user.id));
        ref.invalidate(userHistoryProvider(user.id));
      }
    }

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
            message: '${loc.error}: $failure',
            onRetry: () => ref.invalidate(currentUserProvider),
          ),
          (user) {
            if (user == null) return Center(child: Text(loc.usr_not_found));
            final ratingAsync = ref.watch(userRatingProvider(user.id));
            final historyAsync = ref.watch(userHistoryProvider(user.id));
            return RefreshIndicator(
              onRefresh: refreshAll,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    sliver: SliverToBoxAdapter(
                      child: ProfileCard(
                        user: user,
                        ratingAsync: ratingAsync,
                        isDark: isDark,
                        loc: loc,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        loc.history,
                        style: ThemeTextStyles.regular(isDark: isDark),
                      ),
                    ),
                  ),
                  historyAsync.when(
                    loading: () => const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (err, _) => SliverToBoxAdapter(
                      child: Center(child: Text('${loc.error}: $err')),
                    ),
                    data: (history) {
                      if (history.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(child: Text(loc.admin)),
                        );
                      }
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final record = history[index];
                            return Column(
                              children: [
                                HistoryTile(record: record, isDark: isDark),
                                if (index != history.length - 1)
                                  const Divider(),
                              ],
                            );
                          }, childCount: history.length),
                        ),
                      );
                    },
                  ),
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
