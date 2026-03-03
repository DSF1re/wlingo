import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wlingo/main.dart';

class SpeechNotifier extends AsyncNotifier<String> {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;

  @override
  FutureOr<String> build() {
    return '';
  }

  String _getLocaleId() {
    final prefs = shared;
    switch (prefs.getInt('lang_cource') ?? 2) {
      case 1:
        return 'ru_RU';
      case 2:
        return 'en_US';
      case 3:
        return 'de_DE';
      case 4:
        return 'fr_FR';
      case 5:
        return 'es_ES';
      default:
        return 'en_US';
    }
  }

  Future<void> startRecording() async {
    state = const AsyncLoading();

    if (!_isInitialized) {
      _isInitialized = await _speech.initialize();
    }

    if (!_isInitialized) {
      state = AsyncError('Speech initialization failed', StackTrace.current);
      return;
    }

    final completer = Completer<String>();
    String recognizedText = '';

    await _speech.listen(
      onResult: (result) {
        recognizedText = result.recognizedWords;
        state = AsyncData(recognizedText);

        if (result.finalResult && !completer.isCompleted) {
          completer.complete(recognizedText);
        }
      },
      localeId: _getLocaleId(),
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
    );

    try {
      final finalResult = await completer.future.timeout(
        const Duration(seconds: 11),
        onTimeout: () async {
          await _speech.stop();
          return recognizedText;
        },
      );
      state = AsyncData(finalResult);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> stop() async {
    await _speech.stop();
  }
}
