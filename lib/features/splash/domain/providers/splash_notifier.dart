import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/router.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/splash/domain/providers/splash_state.dart';
import 'package:wlingo/core/global_variables/services.dart';

class SplashAsyncNotifier extends AsyncNotifier<SplashState> {
  late final GoRouter router;

  SplashAsyncNotifier();

  @override
  FutureOr<SplashState> build() async {
    router = ref.read(routerProvider);
    final shared = ref.read(sharedPrefsProvider);

    final bool isFirstLaunch = shared.getBool('isFirstLaunch') ?? true;

    final String initialRoute = isFirstLaunch
        ? Routes.onboarding
        : Routes.login;

    Future.delayed(
      const Duration(seconds: 2),
      () => router.pushReplacement(initialRoute, extra: null),
    );
    return SplashState();
  }
}
