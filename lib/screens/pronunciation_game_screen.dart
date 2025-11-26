import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/core/repositories/options_repository.dart';
import 'package:wlingo/core/repositories/words_repository.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/widgets/microphone_indicator.dart';
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

  Word? currentWord;
  String userSaid = '';
  bool isLoading = false;
  bool? isCorrect;
  bool isMicActive = false;

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

  String getTargetWord(String langCode) {
    if (langCode == 'ru') {
      return currentWord?.russian ?? '';
    } else {
      return currentWord?.word ?? '';
    }
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
                        getTargetWord(
                          _optionsRepository.getCurrentLanguageCode(),
                        ),
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: Colors.green,
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_optionsRepository.getCurrentLanguageCode() == 'ru')
                        Text(
                          currentWord!.word,
                          style: theme.textTheme.titleSmall,
                        )
                      else
                        Text(
                          currentWord!.russian,
                          style: theme.textTheme.titleSmall,
                        ),
                      Text(
                        currentWord!.transcription,
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    MicrophoneIndicatorButton(
                      isActive: isMicActive,
                      onRecordAndCheck: () async {
                        final langCode = _optionsRepository
                            .getCurrentLanguageCode();
                        final speechService = SpeechService(langCode);
                        final userSpeech = await speechService
                            .recordAndRecognize();
                        final bool correct =
                            userSpeech.trim().toLowerCase() ==
                            getTargetWord(langCode).trim().toLowerCase();

                        setState(() {
                          userSaid = userSpeech;
                          isCorrect = correct;
                        });

                        final userId =
                            GetIt.I<SupabaseClient>().auth.currentUser?.id;
                        if (userId == null) {
                          return userSpeech;
                        }

                        await _wordsRepository.saveWordPractice(
                          correctWordId: currentWord!.id,
                          userAnswer: userSpeech,
                          userId: userId,
                          isCorrect: correct,
                        );

                        if (correct) {
                          await _wordsRepository.addOrUpdateRating(userId, 10);
                        }

                        return userSpeech;
                      },
                      onStopListen: () async {
                        final langCode = _optionsRepository
                            .getCurrentLanguageCode();
                        final speechService = SpeechService(langCode);
                        await speechService.stop();
                      },
                      onStateChanged: (active) {
                        setState(() {
                          isMicActive = active;
                        });
                      },
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
