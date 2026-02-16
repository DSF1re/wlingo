import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/features/onboarding/domain/providers/page/page_notifier.dart';

final pageProvider = NotifierProvider<PageNotifier, int>(() {
  return PageNotifier();
});
