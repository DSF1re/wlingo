import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/presentation/providers/speech/speech_provider.dart';
import 'package:wlingo/features/word_practice/presentation/providers/words/words_notifier.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/action_button.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/mic_indicator.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/result_display.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/word_display.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/glass_box.dart';

class PronunciationGameScreen extends HookConsumerWidget {
  const PronunciationGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final wordsState = ref.watch(wordsProvider);
    final speechState = ref.watch(speechNotifierProvider);

    final currentWord = useState<WordEntity?>(null);
    final isCorrect = useState<bool?>(null);

    void pickWord() {
      isCorrect.value = null;
      ref.invalidate(speechNotifierProvider);
      currentWord.value = ref.read(wordsProvider.notifier).getRandomWord();
    }

    useEffect(() {
      if (wordsState.value?.isNotEmpty == true && currentWord.value == null) {
        pickWord();
      }
      return () {
        ref.read(speechNotifierProvider.notifier).stop();
      };
    }, [wordsState.value]);

    Future<String> onRecord() async {
      isCorrect.value = null;
      await ref.read(speechNotifierProvider.notifier).startRecording();

      if (!context.mounted) return '';
      final recognized = ref.read(speechNotifierProvider).value ?? '';

      if (recognized.isNotEmpty && currentWord.value != null) {
        final result = await ref
            .read(wordsProvider.notifier)
            .checkAndSaveResult(
              word: currentWord.value!,
              recognizedText: recognized,
            );

        if (context.mounted) {
          isCorrect.value = result;
        }
      }
      return recognized;
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          const Color(0xFF1A1A2E),
                          const Color(0xFF16213E),
                          const Color(0xFF0F3460),
                        ]
                      : [
                          const Color(0xFFF7F9FC),
                          const Color(0xFFEDF2F7),
                          const Color(0xFFE2E8F0),
                        ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.go(Routes.home),
                            child: GlassBox(
                              padding: const EdgeInsets.all(8),
                              opacity: isDark ? 0.1 : 0.3,
                              blur: 8,
                              borderRadius: BorderRadius.circular(12),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: isDark ? Colors.white : Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              loc.pronunciation,
                              style: ThemeTextStyles.title3SemiBold(
                                isDark: isDark,
                              ),
                            ),
                          ),
                          AppbarActions(isDark: isDark, padding: 0),
                        ],
                      ),
                    ),
                    Expanded(
                      child: wordsState.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, _) =>
                            Center(child: Text('${loc.error}: $err')),
                        data: (words) =>
                            words.isEmpty || currentWord.value == null
                            ? Center(child: Text(loc.error))
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  24,
                                  24,
                                  24,
                                  0,
                                ),
                                child: Column(
                                  children: [
                                    WordDisplay(
                                      word: currentWord.value!,
                                      isDark: isDark,
                                    ),
                                    const Spacer(),
                                    if (speechState.value?.isNotEmpty == true &&
                                        !speechState.isLoading)
                                      ResultDisplay(
                                        text: speechState.value!,
                                        isCorrect: isCorrect.value,
                                        label: loc.you_pronounced,
                                      ),
                                    const SizedBox(height: 32),
                                    MicrophoneIndicatorButton(
                                      isActive: speechState.isLoading,
                                      onRecordAndCheck: () async {
                                        if (speechState.isLoading) {
                                          await ref
                                              .read(
                                                speechNotifierProvider.notifier,
                                              )
                                              .stop();
                                          return "";
                                        }
                                        return await onRecord();
                                      },
                                      onStopListen: () => ref
                                          .read(speechNotifierProvider.notifier)
                                          .stop(),
                                      onStateChanged: (_) {},
                                    ),
                                    const Spacer(),
                                    ActionButton(
                                      label: loc.new_word,
                                      onPressed: speechState.isLoading
                                          ? null
                                          : pickWord,
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
