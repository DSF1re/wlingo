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
    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(
        'Ты — специализированный ИИ-ассистент по языкам и лингвистике для приложения wlingo.\n'
        'Твоя главная и единственная задача — отвечать на вопросы, связанные с языками, лингвистикой, изучением иностранных языков, переводом, грамматикой, лексикой, произношением, этимологией слов и языковой практикой.\n\n'
        'КРИТИЧЕСКИЕ ПРАВИЛА:\n'
        '1. Отвечай ИСКЛЮЧИТЕЛЬНО на вопросы, напрямую связанные с языками, изучением языков и лингвистикой.\n'
        '2. Если пользователь просит тебя решить задачу по математике, написать код на любом языке программирования, рассказать о вещах, не связанных с языками (например, о рецептах, общих фактах, новостях, фильмах, бытовых советах и т.д.), ты ДОЛЖЕН вежливо и дружелюбно отказать, напомнив, что ты специализируешься только на языках и лингвистике.\n'
        '3. Твой ответ при отказе должен быть на том же языке, на котором обратился пользователь. Пример отказа на русском: "К сожалению, я могу помочь вам только с вопросами, связанными с изучением языков и лингвистикой. Пожалуйста, задайте вопрос по этой теме!"\n'
        '4. Будь вежливым, поддерживающим и помогающим в рамках своей специализации.',
      ),
    );
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

class TranscriptionGenerator {
  Future<String?> generate({required String word, required String language}) async {
    if (word.trim().isEmpty) return null;

    final apiKey = dotenv.get('GEMINI');
    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(temperature: 0.1),
    );

    final prompt = 'Give me the IPA phonetic transcription of the word "$word" in $language. Return ONLY the transcription text, nothing else. No slashes, no brackets, no explanations.';

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text?.trim();
    } catch (e) {
      return null;
    }
  }
}

final transcriptionGeneratorProvider = Provider<TranscriptionGenerator>((ref) {
  return TranscriptionGenerator();
});
