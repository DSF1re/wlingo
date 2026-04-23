import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/core/providers/connectivity/connectivity_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';

class ConnectivityListener extends ConsumerWidget {
  final Widget child;
  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(connectivityProvider, (previous, next) {
      next.whenData((status) {
        final l10n = AppLocalizations.of(context);
        if (l10n == null) {
          talker.error('L10n is null in ConnectivityListener');
          return;
        }

        if (status == ConnectivityStatus.disconnected) {
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(
                l10n.no_internet,
                style: ThemeTextStyles.regular(isDark: true),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(days: 1),
              action: SnackBarAction(
                label: l10n.retry,
                onPressed: () {},
                textColor: Colors.white,
              ),
            ),
          );
        } else if (previous?.value == ConnectivityStatus.disconnected &&
            status == ConnectivityStatus.connected) {
          scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(l10n.internet_restored),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    });

    return child;
  }
}
