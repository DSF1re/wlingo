import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/presentation/providers/tts/tts_provider.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/features/word_practice/presentation/providers/speech/speech_provider.dart';
import 'package:wlingo/features/word_practice/presentation/providers/words/words_notifier.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/action_button.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/mic_indicator.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/result_display.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/word_display.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class PronunciationTaskView extends HookConsumerWidget {
  final VoidCallback onNext;

  const PronunciationTaskView({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final wordsState = ref.watch(wordsProvider);
    final speechState = ref.watch(speechNotifierProvider);
    final ttsNotifier = ref.watch(ttsNotifierProvider.notifier);

    final currentWord = useState<WordEntity?>(null);
    final isCorrect = useState<bool?>(null);

    void playWord() {
      if (currentWord.value != null) {
        final langCode = getTtsLanguageCode(currentWord.value!.languageId);
        ttsNotifier.speak(currentWord.value!.word, langCode);
      }
    }

    void pickWord() {
      isCorrect.value = null;
      final notifier = ref.read(speechNotifierProvider.notifier);
      notifier.stop();
      notifier.reset();
      currentWord.value = ref.read(wordsProvider.notifier).getRandomWord();
    }

    useEffect(() {
      if (wordsState.value?.isNotEmpty == true && currentWord.value == null) {
        Future.microtask(() => pickWord());
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
        }
      }
      return recognized;
    }

    return wordsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('${loc.error}: $err')),
      data: (words) => words.isEmpty || currentWord.value == null
          ? Center(child: Text(loc.error))
          : Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                children: [
                  WordDisplay(word: currentWord.value!, isDark: isDark),
                  const SizedBox(height: 16),
                  IconButton(
                    onPressed: playWord,
                    icon: const Icon(Icons.volume_up_rounded, size: 32),
                    color: AppColors.primaryBlue,
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
                        await ref.read(speechNotifierProvider.notifier).stop();
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
                    label: isCorrect.value == true ? loc.next : loc.skip,
                    onPressed: speechState.isLoading ? null : onNext,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}
