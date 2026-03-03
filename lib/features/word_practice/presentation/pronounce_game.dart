import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/home/data/models/word.dart';
import 'package:wlingo/features/word_practice/domain/providers/speech/speech_provider.dart';
import 'package:wlingo/features/word_practice/domain/providers/words/word_provider.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/action_button.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/mic_indicator.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/result_display.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/word_display.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';

class PronunciationGameScreen extends HookConsumerWidget {
  const PronunciationGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final wordsState = ref.watch(wordsNotifierProvider);
    final speechState = ref.watch(speechNotifierProvider);

    final currentWord = useState<Word?>(null);
    final isCorrect = useState<bool?>(null);

    void pickWord() {
      isCorrect.value = null;
      currentWord.value = ref
          .read(wordsNotifierProvider.notifier)
          .getRandomWord();
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
            .read(wordsNotifierProvider.notifier)
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
      appBar: AppBar(
        title: Text(
          loc.ex_pronunce,
          style: ThemeTextStyles.title3SemiBold(isDark: isDark),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.go(Routes.home),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [AppbarActions(isDark: isDark)],
      ),
      body: wordsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('${loc.error}: $err')),
        data: (words) => words.isEmpty || currentWord.value == null
            ? Center(child: Text(loc.error))
            : Padding(
                padding: const EdgeInsets.all(24),
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
                      onStopListen: () =>
                          ref.read(speechNotifierProvider.notifier).stop(),
                      onStateChanged: (_) {},
                    ),
                    const Spacer(),
                    ActionButton(
                      label: loc.new_word,
                      onPressed: speechState.isLoading ? null : pickWord,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
