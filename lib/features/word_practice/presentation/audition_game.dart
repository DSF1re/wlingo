import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';
import 'package:wlingo/features/word_practice/presentation/providers/tts/tts_provider.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/features/word_practice/presentation/providers/words/audition_notifier.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/action_button.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/base_screen.dart';
import 'package:wlingo/widgets/input.dart';

class AuditionGameScreen extends HookConsumerWidget {
  const AuditionGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final auditionState = ref.watch(auditionNotifierProvider);
    final ttsNotifier = ref.watch(ttsNotifierProvider.notifier);

    final currentWord = useState<WordEntity?>(null);
    final isCorrect = useState<bool?>(null);
    final controller = useTextEditingController();
    final isChecked = useState(false);

    void pickWord() {
      isCorrect.value = null;
      isChecked.value = false;
      controller.clear();
      currentWord.value = ref.read(auditionNotifierProvider.notifier).getRandomWord();
    }

    void playWord() {
      if (currentWord.value != null) {
        final langCode = getTtsLanguageCode(currentWord.value!.languageId);
        ttsNotifier.speak(currentWord.value!.word, langCode);
      }
    }

    useEffect(() {
      if (auditionState.value?.isNotEmpty == true && currentWord.value == null) {
        pickWord();
      }
      return null;
    }, [auditionState.value]);

    Future<void> onCheck() async {
      if (currentWord.value != null && controller.text.isNotEmpty) {
        final result = await ref
            .read(auditionNotifierProvider.notifier)
            .checkAndSaveResult(
              word: currentWord.value!,
              typedText: controller.text,
            );
        isCorrect.value = result;
        isChecked.value = true;
      }
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
                  child: const Icon(Icons.arrow_back_rounded),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    loc.audition,
                    style: ThemeTextStyles.title1SemiBold(isDark: isDark),
                  ),
                ),
                AppbarActions(isDark: isDark, padding: 0),
              ],
            ),
          ),
          Expanded(
            child: auditionState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('${loc.error}: $err')),
              data: (words) => words.isEmpty || currentWord.value == null
                  ? Center(child: Text(loc.error))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 48),
                          GestureDetector(
                            onTap: playWord,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryBlue.withValues(alpha: 0.2),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.volume_up_rounded,
                                size: 48,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            loc.listen_and_type,
                            style: ThemeTextStyles.regular(isDark: isDark).copyWith(
                              color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Input(
                            controller: controller,
                            hint: loc.ask_somethink,
                            labelText: loc.word,
                          ),
                          const SizedBox(height: 32),
                          if (isChecked.value) ...[
                            Text(
                              isCorrect.value == true ? loc.correct : loc.error,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: isCorrect.value == true ? AppColors.successGreen : AppColors.errorRed,
                              ),
                            ),
                            if (isCorrect.value == false) ...[
                              const SizedBox(height: 8),
                              Text(
                                '${loc.correct_is}: ${currentWord.value!.word}',
                                style: ThemeTextStyles.regular(isDark: isDark),
                              ),
                            ],
                            const SizedBox(height: 24),
                          ],
                          ActionButton(
                            label: isChecked.value ? loc.new_word : loc.check,
                            onPressed: isChecked.value ? pickWord : onCheck,
                          ),
                          const SizedBox(height: 48),
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
