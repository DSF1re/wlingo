import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/bookview/presentation/providers/add_book_notifier.dart';
import 'package:wlingo/features/bookview/presentation/providers/books_notifier.dart';
import 'package:wlingo/features/home/domain/providers/langlist_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/main.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/glass_box.dart';

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
    final selectedLangId = useState<int>(shared.getInt('lang_cource') ?? 2);

    final languagesAsync = ref.watch(languagesProvider);
    final addState = ref.watch(addBookProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>());

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
      if (formKey.currentState!.validate() && selectedFilePath.value != null) {
        ref
            .read(addBookProvider.notifier)
            .addBook(
              title: titleController.text,
              author: authorController.text,
              filePath: selectedFilePath.value!,
              fileName: selectedFileName.value!,
              languageId: selectedLangId.value,
            );
      } else if (selectedFilePath.value == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(loc.fill_form)));
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          const Color(0xFF1A1A2E),
                          const Color(0xFF16213E),
                          const Color(0xFF0F3460),
                        ]
                      : [
                          const Color(0xFFF7F9FC),
                          const Color(0xFFEDF2F7),
                          const Color(0xFFE2E8F0),
                        ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: GlassBox(
                              padding: const EdgeInsets.all(8),
                              opacity: isDark ? 0.1 : 0.3,
                              blur: 8,
                              borderRadius: BorderRadius.circular(12),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: isDark ? Colors.white : Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              loc.add_study_materials,
                              style: ThemeTextStyles.title3SemiBold(
                                isDark: isDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: addState.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: GlassBox(
                                padding: const EdgeInsets.all(20),
                                opacity: isDark ? 0.08 : 0.4,
                                blur: 12,
                                borderRadius: BorderRadius.circular(24),
                                color: isDark ? Colors.white : Colors.white,
                                border: Border.all(
                                  color: (isDark ? Colors.white : Colors.black)
                                      .withValues(alpha: 0.08),
                                  width: 1,
                                ),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextFormField(
                                        controller: titleController,
                                        decoration: InputDecoration(
                                          labelText: loc.book_name,
                                          border: const OutlineInputBorder(),
                                        ),
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                                ? loc.fill_field
                                                : null,
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: authorController,
                                        decoration: InputDecoration(
                                          labelText: loc.author,
                                          border: const OutlineInputBorder(),
                                        ),
                                        validator: (value) =>
                                            value == null || value.isEmpty
                                                ? loc.fill_field
                                                : null,
                                      ),
                                      const SizedBox(height: 16),
                                      languagesAsync.when(
                                        data: (langs) {
                                          return DropdownButtonFormField<int>(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                            initialValue: langs.any(
                                                    (l) =>
                                                        l.id ==
                                                        selectedLangId.value)
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
                                        loading: () =>
                                            const CircularProgressIndicator(),
                                        error: (err, _) =>
                                            Text(err.toString()),
                                      ),
                                      const SizedBox(height: 24),
                                      ElevatedButton.icon(
                                        onPressed: pickFile,
                                        icon: const Icon(Icons.upload_file),
                                        label: Text(
                                          selectedFileName.value ??
                                              loc.select_upload,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      ElevatedButton(
                                        onPressed: submit,
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                        ),
                                        child: Text(loc.save),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
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
