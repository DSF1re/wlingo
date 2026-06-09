import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/shared/shared_provider.dart';
import 'package:wlingo/features/ai_chat/presentation/providers/ai_chat_provider.dart';
import 'package:wlingo/features/home/data/models/language.dart';
import 'package:wlingo/features/home/presentation/providers/langlist_provider.dart';
import 'package:wlingo/features/word_practice/presentation/providers/add_word_notifier.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/features/vocabulary/presentation/providers/vocabulary_provider.dart';
import 'package:wlingo/features/auth/presentation/providers/current_user_provider.dart';

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

    final languagesAsync = ref.watch(languagesProvider);
    final addState = ref.watch(addWordProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final errorMessage = useState<String?>(null);
    final isTranscribing = useState(false);

    useEffect(() {
      final word = wordController.text.trim();
      if (word.isEmpty) return null;

      final timer = Timer(const Duration(milliseconds: 600), () {
        isTranscribing.value = true;

        final langs = languagesAsync.asData?.value ?? [];
        final langName = langs.firstWhere(
          (l) => l.id == selectedLangId.value,
          orElse: () => Language(id: 1, name: 'English'),
        ).name;

        ref.read(transcriptionGeneratorProvider).generate(
          word: word,
          language: langName,
        ).then((result) {
          if (result != null && result.isNotEmpty) {
            transcriptionController.text = result;
          }
          isTranscribing.value = false;
        });
      });

      return timer.cancel;
    }, [wordController.text, selectedLangId.value, languagesAsync]);

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
            );
      } else {
        // Add to personal dictionary
        ref
            .read(vocabularyListProvider.notifier)
            .addWord(
              word: wordController.text,
              translation: russianController.text,
              transcription: transcriptionController.text,
              languageId: selectedLangId.value,
            );
        context.pop();
      }
    }

    InputDecoration premiumDecoration({
      String? label,
      required IconData icon,
      required bool isDark,
    }) {
      return InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          size: 20,
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: (isDark ? Colors.white : Colors.black).withValues(
          alpha: 0.03,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primaryBlueLight.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        labelStyle: ThemeTextStyles.caption(
          isDark: isDark,
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.15,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    loc.new_word,
                    style: ThemeTextStyles.title1SemiBold(isDark: isDark),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          if (addState.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: wordController,
                            style: ThemeTextStyles.regular(isDark: isDark),
                            decoration: premiumDecoration(
                              label: loc.word,
                              icon: Icons.abc_rounded,
                              isDark: isDark,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? loc.fill_field
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: transcriptionController,
                            readOnly: true,
                            style: ThemeTextStyles.regular(isDark: isDark),
                            decoration: premiumDecoration(
                              label: loc.transcription,
                              icon: Icons.record_voice_over_rounded,
                              isDark: isDark,
                            ).copyWith(
                              suffixIcon: isTranscribing.value
                                  ? const Padding(
                                      padding: EdgeInsets.all(14),
                                      child: SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.primaryBlueLight,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: russianController,
                            style: ThemeTextStyles.regular(isDark: isDark),
                            decoration: premiumDecoration(
                              label: loc.translation,
                              icon: Icons.translate_rounded,
                              isDark: isDark,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? loc.fill_field
                                : null,
                          ),
                          const SizedBox(height: 16),
                          languagesAsync.when(
                            data: (langs) {
                              return DropdownButtonFormField<int>(
                                style: ThemeTextStyles.regular(isDark: isDark),
                                decoration: premiumDecoration(
                                  icon: Icons.language_rounded,
                                  isDark: isDark,
                                ),
                                dropdownColor: isDark
                                    ? const Color(0xFF1A1A2E)
                                    : Colors.white,
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: (isDark ? Colors.white : Colors.black)
                                      .withValues(alpha: 0.5),
                                ),
                                initialValue:
                                    langs.any(
                                      (l) => l.id == selectedLangId.value,
                                    )
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
                            loading: () => const CircularProgressIndicator(),
                            error: (err, _) => Text(err.toString()),
                          ),
                          const SizedBox(height: 32),
                          if (errorMessage.value != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                errorMessage.value!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          Bounceable(
                            onTap: submit,
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.primaryBlueLight,
                                    AppColors.primaryBlueLighter,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryBlueLight
                                        .withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                loc.save,
                                style: ThemeTextStyles.title2Heavy(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
