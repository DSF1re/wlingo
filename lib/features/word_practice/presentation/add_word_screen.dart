import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/shared/shared_provider.dart';
import 'package:wlingo/features/ai_chat/presentation/providers/ai_chat_provider.dart';
import 'package:wlingo/features/home/data/models/language.dart';
import 'package:wlingo/features/home/presentation/providers/langlist_provider.dart';
import 'package:wlingo/features/word_practice/data/repositories/word_repo_impl.dart';
import 'package:wlingo/features/word_practice/presentation/providers/add_word_notifier.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/input_decoration.dart';
import 'package:wlingo/theme/spacing.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/features/vocabulary/presentation/providers/vocabulary_provider.dart';
import 'package:wlingo/features/auth/presentation/providers/current_user_provider.dart';
import 'package:wlingo/widgets/bottom_sheet_shell.dart';
import 'package:wlingo/widgets/gradient_button.dart';

class AddWordScreen extends HookConsumerWidget {
  final String? initialWord;
  final String? initialTranslation;
  const AddWordScreen({super.key, this.initialWord, this.initialTranslation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final wordController = useTextEditingController(text: initialWord);
    final transcriptionController = useTextEditingController();
    final russianController = useTextEditingController(
      text: initialTranslation,
    );

    final selectedLangId = useState<int>(
      ref.read(preferencesServiceProvider).getCourseLanguage(),
    );

    final selectedLevelId = useState<int?>(null);
    final selectedCategoryId = useState<int?>(null);

    final languagesAsync = ref.watch(languagesProvider);
    final levelsAsync = ref.watch(wordLevelsProvider);
    final categoriesAsync = ref.watch(wordCategoriesProvider);
    final addState = ref.watch(addWordProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final errorMessage = useState<String?>(null);
    final isGeneratingTranscription = useState(false);
    final isGeneratingTranslation = useState(false);

    final allCategories = useMemoized(
      () => categoriesAsync.asData?.value ?? [],
      [categoriesAsync],
    );

    Future<void> generateTranscription() async {
      final word = wordController.text.trim();
      if (word.isEmpty) return;

      final langs = languagesAsync.asData?.value ?? [];
      final langName = langs.firstWhere(
        (l) => l.id == selectedLangId.value,
        orElse: () => Language(id: 1, name: 'English'),
      ).name;

      isGeneratingTranscription.value = true;
      try {
        final result = await ref.read(transcriptionGeneratorProvider).generate(
          word: word,
          language: langName,
        );
        if (result != null && result.isNotEmpty) {
          transcriptionController.text = result;
        }
      } finally {
        isGeneratingTranscription.value = false;
      }
    }

    Future<void> generateTranslation() async {
      final word = wordController.text.trim();
      if (word.isEmpty) return;

      final langs = languagesAsync.asData?.value ?? [];
      final langName = langs.firstWhere(
        (l) => l.id == selectedLangId.value,
        orElse: () => Language(id: 1, name: 'English'),
      ).name;

      isGeneratingTranslation.value = true;
      try {
        final result = await ref.read(translationGeneratorProvider).generate(
          word: word,
          language: langName,
        );
        if (result != null && result.isNotEmpty) {
          russianController.text = result;
        }
      } finally {
        isGeneratingTranslation.value = false;
      }
    }

    ref.listen<AsyncValue>(addWordProvider, (_, state) {
      if (state.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${loc.error}: ${state.error}')));
      } else if (!state.isLoading && state.hasValue) {
        context.pop();
      }
    });

    void submit() {
      errorMessage.value = null;
      if (!formKey.currentState!.validate()) {
        errorMessage.value = loc.fill_form;
        return;
      }

      final isAdmin = ref
          .read(currentUserProvider)
          .maybeWhen(
            data: (either) =>
                either.fold((_) => false, (u) => u?.isAdmin ?? false),
            orElse: () => false,
          );

      if (isAdmin) {
        ref
            .read(addWordProvider.notifier)
            .addWord(
              word: wordController.text,
              transcription: transcriptionController.text,
              russian: russianController.text,
              languageId: selectedLangId.value,
              levelId: selectedLevelId.value,
              categoryId: selectedCategoryId.value,
            );
      } else {
        ref
            .read(vocabularyListProvider.notifier)
            .addWord(
              word: wordController.text,
              translation: russianController.text,
              transcription: transcriptionController.text,
              languageId: selectedLangId.value,
              levelId: selectedLevelId.value,
              categoryId: selectedCategoryId.value,
            );
        context.pop();
      }
    }

    Widget generateSuffix({
      required bool isGenerating,
      required VoidCallback onGenerate,
    }) {
      if (isGenerating) {
        return const Padding(
          padding: EdgeInsets.all(14),
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      }
      return GestureDetector(
        onTap: onGenerate,
        child: Tooltip(
          message: loc.generate,
          child: const Padding(
            padding: EdgeInsets.all(14),
            child: Icon(Icons.auto_awesome_rounded, size: 18),
          ),
        ),
      );
    }

    return BottomSheetShell(
      title: loc.new_word,
      isLoading: addState.isLoading,
      errorMessage: errorMessage.value,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: wordController,
              style: ThemeTextStyles.regular(isDark: isDark),
              decoration: formInputDecoration(
                label: loc.word,
                icon: Icons.abc_rounded,
                isDark: isDark,
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? loc.fill_field : null,
            ),
            Spacing.hLg,
            TextFormField(
              controller: transcriptionController,
              style: ThemeTextStyles.regular(isDark: isDark),
              decoration: formInputDecoration(
                label: loc.transcription,
                icon: Icons.record_voice_over_rounded,
                isDark: isDark,
                suffixIcon: generateSuffix(
                  isGenerating: isGeneratingTranscription.value,
                  onGenerate: generateTranscription,
                ),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? loc.fill_field : null,
            ),
            Spacing.hLg,
            TextFormField(
              controller: russianController,
              style: ThemeTextStyles.regular(isDark: isDark),
              decoration: formInputDecoration(
                label: loc.translation,
                icon: Icons.translate_rounded,
                isDark: isDark,
                suffixIcon: generateSuffix(
                  isGenerating: isGeneratingTranslation.value,
                  onGenerate: generateTranslation,
                ),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? loc.fill_field : null,
            ),
            Spacing.hLg,
            languagesAsync.when(
              data: (langs) {
                return DropdownButtonFormField<int>(
                  style: ThemeTextStyles.regular(isDark: isDark),
                  decoration: formInputDecoration(
                    icon: Icons.language_rounded,
                    isDark: isDark,
                  ),
                  dropdownColor:
                      isDark ? const Color(0xFF1A1A2E) : Colors.white,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: (isDark ? Colors.white : Colors.black)
                        .withValues(alpha: 0.5),
                  ),
                  initialValue: langs.any((l) => l.id == selectedLangId.value)
                      ? selectedLangId.value
                      : null,
                  items: langs
                      .map(
                        (l) => DropdownMenuItem(
                          value: l.id,
                          child: Text(l.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      selectedLangId.value = val;
                    }
                  },
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (err, _) => Text(err.toString()),
            ),
            Spacing.hLg,
            levelsAsync.when(
              data: (levels) {
                return DropdownButtonFormField<int>(
                  key: ValueKey('level_${levels.length}'),
                  style: ThemeTextStyles.regular(isDark: isDark),
                  decoration: formInputDecoration(
                    label: loc.level,
                    icon: Icons.bar_chart_rounded,
                    isDark: isDark,
                  ),
                  dropdownColor:
                      isDark ? const Color(0xFF1A1A2E) : Colors.white,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: (isDark ? Colors.white : Colors.black)
                        .withValues(alpha: 0.5),
                  ),
                  items: levels
                      .map(
                        (l) => DropdownMenuItem(
                          value: l.id,
                          child: Text(l.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    selectedLevelId.value = val;
                    selectedCategoryId.value = null;
                  },
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (err, _) => Text(err.toString()),
            ),
            Spacing.hLg,
            categoriesAsync.when(
              data: (_) {
                if (allCategories.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '${loc.category}: нет категорий',
                      style: ThemeTextStyles.regular(
                        isDark: isDark,
                        color: (isDark ? Colors.white : Colors.black)
                            .withValues(alpha: 0.4),
                      ),
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  key: ValueKey('cat_${allCategories.length}'),
                  style: ThemeTextStyles.regular(isDark: isDark),
                  decoration: formInputDecoration(
                    label: loc.category,
                    icon: Icons.category_rounded,
                    isDark: isDark,
                  ),
                  dropdownColor:
                      isDark ? const Color(0xFF1A1A2E) : Colors.white,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: (isDark ? Colors.white : Colors.black)
                        .withValues(alpha: 0.5),
                  ),
                  items: allCategories
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(c.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    selectedCategoryId.value = val;
                  },
                  validator: (value) =>
                      value == null ? loc.fill_field : null,
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (err, _) => Text(err.toString()),
            ),
            Spacing.hXxxl,
            GradientButton(label: loc.save, onTap: submit),
          ],
        ),
      ),
    );
  }
}
