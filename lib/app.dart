import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/core/global_variables/public_vars.dart';
import 'package:wlingo/core/providers/locale/locale_provider.dart';
import 'package:wlingo/core/providers/theme/theme_provider.dart';
import 'package:wlingo/core/providers/connectivity/connectivity_provider.dart';
import 'package:wlingo/core/router/router.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/main.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final thememode = ref.watch(themeProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        themeMode: thememode,
        scaffoldMessengerKey: scaffoldMessengerKey,
        routerConfig: ref.read(routerProvider),
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) {
          return ConnectivityListener(child: child!);
        },
      ),
    );
  }
}

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
              content: Text(l10n.no_internet),
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
