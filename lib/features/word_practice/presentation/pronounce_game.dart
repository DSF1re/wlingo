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
import 'package:wlingo/widgets/base_screen.dart';

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
    final correctCount = useState<int>(0);

    void pickWord() {
      isCorrect.value = null;
      ref.invalidate(speechNotifierProvider);
      currentWord.value = ref.read(wordsProvider.notifier).getRandomWord();
    }

    useEffect(() {
      if (wordsState.value?.isNotEmpty == true && currentWord.value == null) {
        pickWord();
      }
      final notifier = ref.read(speechNotifierProvider.notifier);
      return () {
        notifier.stop();
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
          if (result) {
            correctCount.value++;
          }
        }
      }
      return recognized;
    }

    return BaseScreen(
      isDark: isDark,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go(Routes.home),
                  child: Icon(Icons.arrow_back_rounded),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.pronunciation,
                        style: ThemeTextStyles.title3SemiBold(isDark: isDark),
                      ),
                      Text(
                        '${loc.correct}: ${correctCount.value}',
                        style: ThemeTextStyles.caption(
                          isDark: isDark,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                AppbarActions(isDark: isDark, padding: 0),
              ],
            ),
          ),
          Expanded(
            child: wordsState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('${loc.error}: $err')),
              data: (words) => words.isEmpty || currentWord.value == null
                  ? Center(child: Text(loc.error))
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Column(
                        children: [
                          WordDisplay(word: currentWord.value!, isDark: isDark),
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
                                    .read(speechNotifierProvider.notifier)
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
                            onPressed: speechState.isLoading ? null : pickWord,
                          ),
                          const SizedBox(height: 24),
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
