import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/vocabulary/presentation/providers/vocabulary_provider.dart';
import 'package:wlingo/features/word_practice/presentation/providers/tts/tts_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/base_screen.dart';
import 'package:wlingo/widgets/glass_box.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class VocabularyListScreen extends HookConsumerWidget {
  const VocabularyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final vocabState = ref.watch(vocabularyListProvider);
    final ttsNotifier = ref.watch(ttsNotifierProvider.notifier);

    return BaseScreen(
      isDark: isDark,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  loc.my_vocabulary,
                  style: ThemeTextStyles.custom(isDark: isDark, fontSize: 22),
                ),
              ],
            ),
          ),
          Expanded(
            child: vocabState.when(
              data: (words) => words.isEmpty
                  ? Center(child: Text(loc.empty_list))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        final word = words[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GlassBox(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            opacity: isDark ? 0.04 : 0.35,
                            blur: 10,
                            borderRadius: BorderRadius.circular(20),
                            color: isDark ? Colors.white : Colors.white,
                            border: Border.all(
                              color: (isDark ? Colors.white : Colors.black)
                                  .withValues(alpha: 0.08),
                              width: 1,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        word.word,
                                        style: ThemeTextStyles.title3SemiBold(
                                          isDark: isDark,
                                        ),
                                      ),
                                      if (word.transcription != null &&
                                          word.transcription!.isNotEmpty)
                                        Text(
                                          '[${word.transcription}]',
                                          style: ThemeTextStyles.caption(
                                            isDark: isDark,
                                            color:
                                                (isDark
                                                        ? Colors.white
                                                        : Colors.black)
                                                    .withValues(alpha: 0.5),
                                          ),
                                        ),
                                      Text(
                                        word.translation,
                                        style: ThemeTextStyles.regular(
                                          isDark: isDark,
                                          color:
                                              (isDark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Bounceable(
                                  onTap: () {
                                    final langCode = getTtsLanguageCode(
                                      word.languageId,
                                    );
                                    ttsNotifier.speak(word.word, langCode);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBlue.withValues(
                                        alpha: 0.15,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Icon(
                                      Icons.volume_up_rounded,
                                      size: 26,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text(err.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
