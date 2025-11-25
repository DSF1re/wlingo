import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wlingo/core/repositories/options_repository.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/screens/pronunciation_game_screen.dart';

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
            icon: const Icon(Icons.language),
          ),
          IconButton(
            onPressed: _optionsRepository.toggleTheme,
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 250,
                height: 80,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.record_voice_over, size: 32),
                  label: Text(
                    AppLocalizations.of(context)!.pronunciation,
                    style: theme.textTheme.bodyMedium,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.all(16),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PronunciationGameScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
