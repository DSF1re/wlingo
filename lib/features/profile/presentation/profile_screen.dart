import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/auth/domain/providers/current_user_provider.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: userAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('${loc.error}: $err'),
            data: (either) => either.fold(
              (failure) => Text('${loc.error}: ${failure.toString()}'),
              (user) {
                if (user == null) return Text(loc.usr_not_found);
                return Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName} ${user.middleName}',
                      style: ThemeTextStyles.title1SemiBold(isDark: isDark),
                    ),
                    Text(
                      'ID: ${user.id}',
                      style: ThemeTextStyles.regular(isDark: isDark),
                    ),
                    if (user.isAdmin) Chip(label: Text(loc.admin)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
