import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wlingo/core/global_variables/services.dart';

class SpeechNotifier extends AsyncNotifier<String> {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;
  Completer<String>? _currentCompleter;
  int _sessionId = 0;

  @override
  FutureOr<String> build() {
    return '';
  }

  String _getLocaleId() {
    final prefs = ref.read(sharedPrefsProvider);
    switch (prefs.getInt('lang_course') ?? prefs.getInt('lang_cource') ?? 2) {
      case 1:
        return 'ru-RU';
      case 2:
        return 'en-US';
      case 3:
        return 'de-DE';
      case 4:
        return 'fr-FR';
      case 5:
        return 'es-ES';
      case 6:
        return 'tr-TR';
      default:
        return 'en-US';
    }
  }

  Future<void> startRecording() async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    final sessionId = ++_sessionId;

    if (!_isInitialized) {
      _isInitialized = await _speech.initialize(
        onError: (error) => debugPrint('Speech Error: $error'),
        onStatus: (status) {
          debugPrint('Speech Status: $status');
          if (status == 'done' || status == 'notListening') {
            if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
              _currentCompleter!.complete(state.value ?? '');
            }
          }
        },
      );
    }

    if (!_isInitialized) {
      if (_sessionId == sessionId) {
        state = AsyncError('Speech initialization failed', StackTrace.current);
      }
      return;
    }

    final completer = Completer<String>();
    _currentCompleter = completer;
    String recognizedText = '';

    await _speech.listen(
      onResult: (result) {
        if (_sessionId != sessionId) return;
        
        recognizedText = result.recognizedWords;
        state = AsyncData(recognizedText);

        if (result.finalResult && !completer.isCompleted) {
          completer.complete(recognizedText);
        }
      },
      localeId: _getLocaleId(),
      listenFor: const Duration(seconds: 7),
      pauseFor: const Duration(seconds: 3),
    );

    try {
      final finalResult = await completer.future.timeout(
        const Duration(seconds: 11),
        onTimeout: () => recognizedText,
      );
      
      if (_sessionId == sessionId) {
        state = AsyncData(finalResult);

        if (finalResult.isNotEmpty) {
          Future.delayed(const Duration(seconds: 5), () {
            if (_sessionId == sessionId && state.value == finalResult) {
              state = const AsyncData('');
            }
          });
        }
      }
    } catch (e, st) {
      if (_sessionId == sessionId) {
        state = AsyncError(e, st);
      }
    } finally {
      if (_sessionId == sessionId) {
        _currentCompleter = null;
        await _speech.stop();
      }
    }
  }

  Future<void> stop() async {
    _sessionId++;
    await _speech.stop();
    if (_currentCompleter != null && !_currentCompleter!.isCompleted) {
      _currentCompleter!.complete(state.value ?? '');
    }
    _currentCompleter = null;
    if (state.isLoading) {
      state = AsyncData(state.value ?? '');
    }
  }

  void reset() {
    _sessionId++;
    state = const AsyncData('');
    _currentCompleter = null;
  }
}
