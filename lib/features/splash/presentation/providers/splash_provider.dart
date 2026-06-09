import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/splash/presentation/providers/splash_notifier.dart';
import 'package:wlingo/features/splash/presentation/providers/splash_state.dart';

final splashProvider =
    AsyncNotifierProvider.autoDispose<SplashAsyncNotifier, SplashState>(() {
      return SplashAsyncNotifier();
    });
