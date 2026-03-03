import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/home/data/models/word.dart';
import 'package:wlingo/features/word_practice/domain/providers/words/words_notifier.dart';

final wordsNotifierProvider = AsyncNotifierProvider<WordsNotifier, List<Word>>(
  () {
    return WordsNotifier();
  },
);
