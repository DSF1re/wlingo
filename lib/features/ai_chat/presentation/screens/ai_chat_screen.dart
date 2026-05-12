import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/ai_chat/presentation/providers/ai_chat_provider.dart';
import 'package:wlingo/features/ai_chat/presentation/widgets/message_bubble.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/base_screen.dart';

class AiChatScreen extends HookConsumerWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final messages = ref.watch(aiChatProvider);
    final isTyping = ref.watch(isAiTypingProvider);

    final textController = useTextEditingController();
    final scrollController = useScrollController();

    useEffect(() {
      if (messages.isNotEmpty || isTyping) {
        Future.microtask(() {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
      return null;
    }, [messages.length, isTyping]);

    void onSend() {
      final text = textController.text.trim();
      if (text.isNotEmpty && !isTyping) {
        ref.read(aiChatProvider.notifier).sendMessage(text);
        textController.clear();
      }
    }

    return BaseScreen(
      isDark: isDark,
      safeAreaBottom: true,
      maxWidth: 800,
      appBar: AppBar(
        title: Text(
          loc.ai_chat,
          style: ThemeTextStyles.custom(isDark: isDark, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final message = messages[index];
                return MessageBubble(
                  text: message.text,
                  isUser: message.isUser,
                  isDark: isDark,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    style: ThemeTextStyles.regular(isDark: isDark),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => onSend(),
                    decoration: InputDecoration(
                      hintText: loc.ask_somethink,
                      filled: true,
                      fillColor: isDark
                          ? AppColors.inputDark
                          : AppColors.inputLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: isTyping ? null : onSend,
                  icon: const Icon(Icons.send_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primaryBlueLight,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
