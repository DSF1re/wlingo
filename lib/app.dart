import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/core/providers/locale/locale_provider.dart';
import 'package:wlingo/core/providers/theme/theme_provider.dart';
import 'package:wlingo/core/router/router.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/widgets/connectivity_listener.dart';

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
