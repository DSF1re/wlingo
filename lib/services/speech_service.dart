import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final ValueNotifier<String> languageNotifier;
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;

  SpeechService(this.languageNotifier);

  String getLocaleId() {
    switch (languageNotifier.value) {
      case 'ru':
        return 'ru_RU'; // Russian
      case 'en':
        return 'en_US'; // English (US)
      case 'de':
        return 'de_DE'; // German (Germany)
      case 'fr':
        return 'fr_FR'; // French (France)
      case 'es':
        return 'es_ES'; // Spanish (Spain)
      default:
        return 'en_US';
    }
  }

  Future<String> recordAndRecognize() async {
    _isInitialized = await _speech.initialize();
    if (!_isInitialized) return '';

    String recognizedText = '';

    await _speech.listen(
      onResult: (result) {
        recognizedText = result.recognizedWords;
      },
      localeId: getLocaleId(),
      listenFor: Duration(seconds: 6),
    );

    await Future.delayed(Duration(seconds: 6));
    await _speech.stop();

    return recognizedText;
  }

  Future<void> stop() async {
    await _speech.stop();
  }
}
