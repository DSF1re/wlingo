import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/onboarding/presentation/providers/page/page_notifier.dart';

final pageProvider = NotifierProvider<PageNotifier, int>(() {
  return PageNotifier();
});
