import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wlingo/main.dart';

class SpeechNotifier extends AsyncNotifier<String> {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;
  Completer<String>? _currentCompleter;

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
    if (state.isLoading) return;

    state = const AsyncLoading();

    if (!_isInitialized) {
      _isInitialized = await _speech.initialize(
        onError: (error) => debugPrint('Speech Error: $error'),
      );
    }

    if (!_isInitialized) {
      state = AsyncError('Speech initialization failed', StackTrace.current);
      return;
    }

    _currentCompleter = Completer<String>();
    String recognizedText = '';

    await _speech.listen(
      onResult: (result) {
        recognizedText = result.recognizedWords;
        state = AsyncData(recognizedText);

        if (result.finalResult && _currentCompleter?.isCompleted == false) {
          _currentCompleter?.complete(recognizedText);
        }
      },
      localeId: _getLocaleId(),
      listenFor: const Duration(seconds: 7),
      pauseFor: const Duration(seconds: 3),
    );

    try {
      final finalResult = await _currentCompleter!.future.timeout(
        const Duration(seconds: 11),
        onTimeout: () => recognizedText,
      );
      state = AsyncData(finalResult);
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _currentCompleter = null;
      await _speech.stop();
    }
  }

  Future<void> stop() async {
    await _speech.stop();
    if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
      _currentCompleter?.complete(state.value ?? '');
    }
  }
}
