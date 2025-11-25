import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;

  Future<String> recordAndRecognize() async {
    if (!_isInitialized) {
      _isInitialized = await _speech.initialize(
        onStatus: (status) {},
        onError: (errorNotification) {},
      );
    }
    if (!_isInitialized) return '';

    String recognizedText = '';

    await _speech.listen(
      onResult: (result) {
        recognizedText = result.recognizedWords;
      },
      localeId: 'en_US',
      listenFor: Duration(seconds: 6),
    );

    await Future.delayed(Duration(seconds: 3));
    await _speech.stop();

    return recognizedText;
  }
}
