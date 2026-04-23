import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/features/bookview/presentation/providers/add_book_notifier.dart';
import 'package:wlingo/features/bookview/presentation/providers/books_notifier.dart';
import 'package:wlingo/features/home/domain/providers/langlist_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';

class AddBookScreen extends HookConsumerWidget {
  const AddBookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final titleController = useTextEditingController();
    final authorController = useTextEditingController();

    final selectedFilePath = useState<String?>(null);
    final selectedFileName = useState<String?>(null);
    final prefs = ref.read(sharedPrefsProvider);
    final selectedLangId = useState<int>(
      prefs.getInt('lang_course') ?? prefs.getInt('lang_cource') ?? 2,
    );

    final languagesAsync = ref.watch(languagesProvider);
    final addState = ref.watch(addBookProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final errorMessage = useState<String?>(null);

    ref.listen<AsyncValue>(addBookProvider, (_, state) {
      if (state.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${loc.error}: ${state.error}')));
      } else if (!state.isLoading && state.hasValue) {
        ref.invalidate(booksProvider);
        context.pop();
      }
    });

    Future<void> pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        selectedFilePath.value = result.files.single.path;
        selectedFileName.value = result.files.single.name;
      }
    }

    void submit() {
      errorMessage.value = null;
      final isFormValid = formKey.currentState!.validate();

      if (!isFormValid || selectedFilePath.value == null) {
        if (!isFormValid && selectedFilePath.value == null) {
          errorMessage.value = loc.fill_form;
        } else if (!isFormValid) {
          errorMessage.value = loc.fill_form;
        } else if (selectedFilePath.value == null) {
          errorMessage.value = '${loc.error}: ${loc.select_upload}';
        }
        return;
      }

      ref
          .read(addBookProvider.notifier)
          .addBook(
            title: titleController.text,
            author: authorController.text,
            filePath: selectedFilePath.value!,
            fileName: selectedFileName.value!,
            languageId: selectedLangId.value,
          );
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
                    loc.add_study_materials,
                    style: ThemeTextStyles.title1SemiBold(isDark: isDark),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(Icons.close_rounded),
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
                            controller: titleController,
                            style: ThemeTextStyles.regular(isDark: isDark),
                            decoration: premiumDecoration(
                              label: loc.book_name,
                              icon: Icons.title_rounded,
                              isDark: isDark,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? loc.fill_field
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: authorController,
                            style: ThemeTextStyles.regular(isDark: isDark),
                            decoration: premiumDecoration(
                              label: loc.author,
                              icon: Icons.person_rounded,
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
                          const SizedBox(height: 24),
                          Bounceable(
                            onTap: pickFile,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: (isDark ? Colors.white : Colors.black)
                                    .withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      errorMessage.value != null &&
                                          selectedFilePath.value == null
                                      ? Colors.red.withValues(alpha: 0.8)
                                      : (isDark ? Colors.white : Colors.black)
                                            .withValues(alpha: 0.1),
                                  style: BorderStyle.solid,
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    selectedFileName.value != null
                                        ? Icons.check_circle_rounded
                                        : Icons.cloud_upload_rounded,
                                    size: 40,
                                    color: selectedFileName.value != null
                                        ? AppColors.greenLight
                                        : AppColors.primaryBlueLight,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    selectedFileName.value ?? loc.select_upload,
                                    textAlign: TextAlign.center,
                                    style: ThemeTextStyles.regular(
                                      isDark: isDark,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (selectedFileName.value == null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      loc.pdf_files_only,
                                      style: ThemeTextStyles.caption(
                                        isDark: isDark,
                                        color:
                                            (isDark
                                                    ? Colors.white
                                                    : Colors.black)
                                                .withValues(alpha: 0.4),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
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
