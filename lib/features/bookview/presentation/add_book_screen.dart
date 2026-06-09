import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/features/bookview/presentation/providers/add_book_notifier.dart';
import 'package:wlingo/features/bookview/presentation/providers/books_notifier.dart';
import 'package:wlingo/features/home/presentation/providers/langlist_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/input_decoration.dart';
import 'package:wlingo/theme/spacing.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/bottom_sheet_shell.dart';
import 'package:wlingo/widgets/gradient_button.dart';

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
        allowedExtensions: ['pdf', 'md'],
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

    return BottomSheetShell(
      title: loc.add_study_materials,
      isLoading: addState.isLoading,
      errorMessage: errorMessage.value,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: titleController,
              style: ThemeTextStyles.regular(isDark: isDark),
              decoration: formInputDecoration(
                label: loc.book_name,
                icon: Icons.title_rounded,
                isDark: isDark,
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? loc.fill_field : null,
            ),
            Spacing.hLg,
            TextFormField(
              controller: authorController,
              style: ThemeTextStyles.regular(isDark: isDark),
              decoration: formInputDecoration(
                label: loc.author,
                icon: Icons.person_rounded,
                isDark: isDark,
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
              loading: () => const CircularProgressIndicator(),
              error: (err, _) => Text(err.toString()),
            ),
            Spacing.hXxl,
            Bounceable(
              onTap: pickFile,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: (isDark ? Colors.white : Colors.black).withValues(
                    alpha: 0.03,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: errorMessage.value != null &&
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
                    Spacing.hMd,
                    Text(
                      selectedFileName.value ?? loc.select_upload,
                      textAlign: TextAlign.center,
                      style: ThemeTextStyles.regular(
                        isDark: isDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (selectedFileName.value == null) ...[
                      Spacing.hXs,
                      Text(
                        loc.pdf_files_only,
                        style: ThemeTextStyles.caption(
                          isDark: isDark,
                          color: (isDark ? Colors.white : Colors.black)
                              .withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Spacing.hXxxl,
            GradientButton(label: loc.save, onTap: submit),
          ],
        ),
      ),
    );
  }
}
