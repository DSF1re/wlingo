import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/ai_chat/domain/models/chat_message.dart';

class IsAiTypingNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void setTyping(bool value) => state = value;
}

final isAiTypingProvider = NotifierProvider<IsAiTypingNotifier, bool>(() {
  return IsAiTypingNotifier();
});

class AiChatNotifier extends Notifier<List<ChatMessage>> {
  late final ChatSession _chat;
  bool _isInitialized = false;

  @override
  List<ChatMessage> build() {
    _initChat();
    return [];
  }

  void _initChat() {
    final apiKey = dotenv.get('GEMINI');
    final model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
    _chat = model.startChat();
    _isInitialized = true;
  }

  Future<void> sendMessage(String text) async {
    if (!_isInitialized || text.trim().isEmpty) return;

    state = [
      ...state,
      ChatMessage(text: text, isUser: true, createdAt: DateTime.now()),
    ];

    ref.read(isAiTypingProvider.notifier).setTyping(true);

    try {
      final response = await _chat.sendMessage(Content.text(text));
      final responseText = response.text;
      if (responseText != null) {
        state = [
          ...state,
          ChatMessage(
            text: responseText,
            isUser: false,
            createdAt: DateTime.now(),
          ),
        ];
      }
    } catch (e) {
      state = [
        ...state,
        ChatMessage(
          text: e.toString(),
          isUser: false,
          createdAt: DateTime.now(),
        ),
      ];
    } finally {
      ref.read(isAiTypingProvider.notifier).setTyping(false);
    }
  }
}

final aiChatProvider = NotifierProvider<AiChatNotifier, List<ChatMessage>>(() {
  return AiChatNotifier();
});
