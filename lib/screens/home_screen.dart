import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wlingo/core/repositories/options_repository.dart';
import 'package:wlingo/core/service_locator.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/screens/books_screen.dart';
import 'package:wlingo/screens/ollama_chat_screen.dart';
import 'package:wlingo/screens/pronunciation_game_screen.dart';
import 'package:wlingo/widgets/language_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late OptionsRepository _optionsRepository;

  @override
  void initState() {
    super.initState();
    _optionsRepository = GetIt.I<OptionsRepository>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home),
        actions: [
          IconButton(
            onPressed: _optionsRepository.toggleLanguage,
            icon: const Icon(Icons.translate),
          ),
          IconButton(
            onPressed: _optionsRepository.toggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.record_voice_over, size: 32),
            title: Text(
              AppLocalizations.of(context)!.pronunciation,
              style: theme.textTheme.titleLarge,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            tileColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PronunciationGameScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.book, size: 32),
            title: Text(
              AppLocalizations.of(context)!.study_materials,
              style: theme.textTheme.titleLarge,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            tileColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const BooksScreen()));
            },
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<String>(
            valueListenable: languageNotifier,
            builder: (context, value, _) {
              return LanguagePickerListTile(
                currentLanguageCode: value,
                onLanguageChanged: (newLang) {
                  languageNotifier.value = newLang;
                },
              );
            },
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.smart_toy, size: 32),
            title: Text(
              AppLocalizations.of(context)!.ai_chat,
              style: theme.textTheme.titleLarge,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            tileColor: theme.colorScheme.primary.withValues(alpha: 0.1),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const OllamaChatScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
