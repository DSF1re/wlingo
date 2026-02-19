import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wlingo/core/router/router.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/splash/domain/providers/splash_state.dart';
import 'package:wlingo/main.dart';

class SplashAsyncNotifier extends AsyncNotifier<SplashState> {
  late final GoRouter router;

  SplashAsyncNotifier();

  @override
  FutureOr<SplashState> build() async {
    router = ref.read(routerProvider);

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
