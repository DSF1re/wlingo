import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/word_practice/presentation/providers/speech/speech_notifier.dart';

final speechNotifierProvider = AsyncNotifierProvider<SpeechNotifier, String>(
  () {
    return SpeechNotifier();
  },
);
