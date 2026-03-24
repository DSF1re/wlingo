import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tts_provider.g.dart';

@riverpod
FlutterTts tts(Ref ref) {
  final tts = FlutterTts();
  return tts;
}

@Riverpod(name: 'ttsNotifierProvider')
class TtsNotifier extends _$TtsNotifier {
  @override
  FutureOr<void> build() async {
    final tts = ref.watch(ttsProvider);
    ref.onDispose(() => tts.stop());
    
    await tts.setLanguage("en-US");
    if (!ref.mounted) return;
    await tts.setSpeechRate(0.5);
    if (!ref.mounted) return;
    await tts.setVolume(1.0);
    if (!ref.mounted) return;
    await tts.setPitch(1.0);
  }

  Future<void> speak(String text, String languageCode) async {
    final tts = ref.read(ttsProvider);
    await tts.setLanguage(languageCode);
    await tts.speak(text);
  }

  Future<void> stop() async {
    final tts = ref.read(ttsProvider);
    await tts.stop();
  }
}
