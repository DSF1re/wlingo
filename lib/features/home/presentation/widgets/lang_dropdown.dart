import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/home/data/models/language.dart';
import 'package:wlingo/features/word_practice/presentation/providers/lang_state/lang_state_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/widgets/glass_box.dart';

class LanguageDropdown extends HookConsumerWidget {
  final List<Language> languages;
  final ValueNotifier<int?> selectedId;

  const LanguageDropdown({
    super.key,
    required this.languages,
    required this.selectedId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    return GlassBox(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      opacity: isDark ? 0.05 : 0.2,
      blur: 10,
      borderRadius: BorderRadius.circular(24),
      color: isDark ? Colors.white : Colors.white,
      border: Border.all(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
        width: 1,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          borderRadius: BorderRadius.circular(24),
          dropdownColor: isDark ? Colors.grey[900] : Colors.white,
          value: languages.any((w) => w.id == selectedId.value)
              ? selectedId.value
              : null,
          isExpanded: true,
          hint: Text(
            loc.select_course,
            style: TextStyle(
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.5,
              ),
            ),
          ),
          items: languages.map((lang) {
            return DropdownMenuItem<int>(
              value: lang.id,
              child: Text(
                lang.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            );
          }).toList(),
          onChanged: (int? newValue) {
            if (newValue != null) {
              selectedId.value = newValue;
              ref
                  .read(langStateProvider.notifier)
                  .setSelectedCourseId(newValue);
            }
          },
        ),
      ),
    );
  }
}
