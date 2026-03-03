import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/auth/domain/providers/current_user_provider.dart';
import 'package:wlingo/features/profile/domain/providers/history_provider.dart';
import 'package:wlingo/features/profile/domain/providers/rating_provider.dart';
import 'package:wlingo/features/profile/presentation/widgets/history_tile.dart';
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
        error: (err, _) => Center(child: Text('${loc.error}: $err')),
        data: (either) => either.fold(
          (failure) => Center(child: Text('${loc.error}: $failure')),
          (user) {
            if (user == null) return Center(child: Text(loc.usr_not_found));

            final ratingAsync = ref.watch(userRatingProvider(user.id));
            final historyAsync = ref.watch(userHistoryProvider(user.id));

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8,
                        children: [
                          Text(
                            '${user.firstName} ${user.lastName}',
                            style: ThemeTextStyles.title1SemiBold(
                              isDark: isDark,
                            ),
                          ),
                          ratingAsync.when(
                            data: (points) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  '${loc.rating}: $points',
                                  style: ThemeTextStyles.regular(
                                    isDark: isDark,
                                  ),
                                ),
                              ],
                            ),
                            loading: () => const CircularProgressIndicator(),
                            error: (_, _) => const Text('—'),
                          ),
                          if (user.isAdmin)
                            Chip(
                              label: Text(
                                loc.admin,
                                style: ThemeTextStyles.regular(isDark: isDark),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  Text(
                    loc.history,
                    style: ThemeTextStyles.regular(isDark: isDark),
                  ),

                  Expanded(
                    child: historyAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, _) =>
                          Center(child: Text('${loc.error}: $err')),
                      data: (history) {
                        if (history.isEmpty) {
                          return Center(child: Text(loc.admin));
                        }
                        return ListView.separated(
                          itemCount: history.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            return HistoryTile(
                              record: history[index],
                              isDark: isDark,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
