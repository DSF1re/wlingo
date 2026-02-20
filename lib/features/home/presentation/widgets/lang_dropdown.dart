import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/home/data/models/language.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/main.dart';

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
    final loc = AppLocalizations.of(context)!;
    return DropdownButton<int>(
      value: languages.any((w) => w.id == selectedId.value)
          ? selectedId.value
          : null,
      isExpanded: true,
      hint: Text(loc.select_course),
      items: languages.map((lang) {
        return DropdownMenuItem<int>(value: lang.id, child: Text(lang.name));
      }).toList(),
      onChanged: (int? newValue) {
        if (newValue != null) {
          selectedId.value = newValue;
          shared.setInt('lang_cource', newValue);
        }
      },
    );
  }
}
