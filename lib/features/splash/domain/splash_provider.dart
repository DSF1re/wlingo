import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/features/splash/domain/splash_notifier.dart';
import 'package:wlingo/features/splash/domain/splash_state.dart';

final splashProvider =
    AsyncNotifierProvider.autoDispose<SplashAsyncNotifier, SplashState>(() {
      return SplashAsyncNotifier();
    });
