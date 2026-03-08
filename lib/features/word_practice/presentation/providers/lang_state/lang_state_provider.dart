import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/word_practice/presentation/providers/lang_state/lang_state_notifier.dart';

final langStateProvider = NotifierProvider<LangStateNotifier, int>(() {
  return LangStateNotifier();
});
