import 'package:flutter/material.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class LanguagePickerListTile extends StatelessWidget {
  const LanguagePickerListTile({
    super.key,
    required this.currentLanguageCode,
    required this.onLanguageChanged,
  });

  final String currentLanguageCode;
  final ValueChanged<String> onLanguageChanged;

  final languages = const [
    {'code': 'en', 'name': 'English'},
    {'code': 'ru', 'name': 'Русский'},
    {'code': 'es', 'name': 'Español'},
    {'code': 'de', 'name': 'Deutsch'},
    {'code': 'fr', 'name': 'Français'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Image.asset('assets/images/select.png', width: 32, height: 32),
      title: Text(
        AppLocalizations.of(context)!.select_course,
        style: theme.textTheme.titleLarge,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      tileColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      trailing: DropdownButton<String>(
        value: currentLanguageCode,
        borderRadius: BorderRadius.circular(12),
        underline: const SizedBox(),
        focusColor: Colors.transparent,
        items: languages.map((lang) {
          final code = lang['code']!;
          return DropdownMenuItem<String>(
            value: code,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/icons/$code.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onLanguageChanged(value);
          }
        },
      ),
    );
  }
}
