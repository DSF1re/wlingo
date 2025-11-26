import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final String langCode; // "ru" или "en"
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;

  SpeechService(this.langCode);

  String getLocaleId() {
    switch (langCode) {
      case "ru":
        return "ru_RU";
      case "en":
      default:
        return "en_US";
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
