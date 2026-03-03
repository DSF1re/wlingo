import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/home/data/models/word.dart';
import 'package:wlingo/features/word_practice/domain/providers/speech/speech_provider.dart';
import 'package:wlingo/features/word_practice/domain/providers/words/word_provider.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/mic_indicator.dart';
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
      return null;
    }, [wordsState.value]);

    Future<String> onRecord() async {
      isCorrect.value = null;
      await ref.read(speechNotifierProvider.notifier).startRecording();

      final recognized = ref.read(speechNotifierProvider).value ?? '';

      if (recognized.isNotEmpty && currentWord.value != null) {
        isCorrect.value = await ref
            .read(wordsNotifierProvider.notifier)
            .checkAndSaveResult(
              word: currentWord.value!,
              recognizedText: recognized,
            );
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
                    _WordDisplay(word: currentWord.value!, isDark: isDark),
                    const Spacer(),
                    if (speechState.value?.isNotEmpty == true &&
                        !speechState.isLoading)
                      _ResultDisplay(
                        text: speechState.value!,
                        isCorrect: isCorrect.value,
                        label: loc.you_pronounced,
                      ),
                    const SizedBox(height: 32),
                    MicrophoneIndicatorButton(
                      isActive: speechState.isLoading,
                      onRecordAndCheck: () async => (await onRecord(), "").$1,
                      onStopListen: () =>
                          ref.read(speechNotifierProvider.notifier).stop(),
                      onStateChanged: (_) {},
                    ),
                    const Spacer(),
                    _ActionButton(
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

class _WordDisplay extends StatelessWidget {
  final Word word;
  final bool isDark;
  const _WordDisplay({required this.word, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          word.word,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '[ ${word.transcription} ]',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.blueAccent.withValues(alpha: 0.5),
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          word.russian,
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.black54,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _ResultDisplay extends StatelessWidget {
  final String text;
  final bool? isCorrect;
  final String label;
  const _ResultDisplay({
    required this.text,
    required this.isCorrect,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCorrect == null
        ? null
        : (isCorrect! ? Colors.green : Colors.red);
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _ActionButton({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
