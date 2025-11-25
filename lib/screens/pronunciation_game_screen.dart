import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wlingo/core/repositories/options_repository.dart';
import 'package:wlingo/core/repositories/words_repository.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import '../services/speech_service.dart';
import '../models/word.dart';

class PronunciationGameScreen extends StatefulWidget {
  const PronunciationGameScreen({super.key});

  @override
  State<PronunciationGameScreen> createState() =>
      _PronunciationGameScreenState();
}

class _PronunciationGameScreenState extends State<PronunciationGameScreen> {
  late WordsRepository _wordsRepository;
  late OptionsRepository _optionsRepository;
  final speechService = SpeechService();

  Word? currentWord;
  String userSaid = '';
  bool isLoading = false;
  bool? isCorrect;

  @override
  void initState() {
    super.initState();
    _wordsRepository = GetIt.I<WordsRepository>();
    _optionsRepository = GetIt.I<OptionsRepository>();
    _getNewWord();
  }

  Future<void> _getNewWord() async {
    setState(() {
      isLoading = true;
      userSaid = '';
      isCorrect = null;
    });
    currentWord = await _wordsRepository.fetchRandomWord();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _checkPronunciation() async {
    userSaid = await speechService.recordAndRecognize();
    isCorrect =
        userSaid.trim().toLowerCase() == currentWord?.word.trim().toLowerCase();
    setState(() {});
  }

  Color getResultColor() {
    if (isCorrect == null) return Colors.black;
    return isCorrect! ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.ex_pronunce),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    if (currentWord != null) ...[
                      Text(
                        currentWord!.word,
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        currentWord!.transcription,
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Text(
                        currentWord!.russian,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _checkPronunciation,
                      child: Text(
                        AppLocalizations.of(context)!.check_pronunciation,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (userSaid.isNotEmpty)
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.you_pronounced,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            userSaid,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: getResultColor(),
                            ),
                          ),
                        ],
                      ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _getNewWord,
                      child: Text(AppLocalizations.of(context)!.new_word),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
