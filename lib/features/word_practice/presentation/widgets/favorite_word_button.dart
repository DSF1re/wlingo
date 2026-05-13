import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/vocabulary/presentation/providers/vocabulary_provider.dart';
import 'package:wlingo/features/word_practice/domain/entities/word_entity.dart';

class FavoriteWordButton extends HookConsumerWidget {
  final WordEntity word;
  final double size;

  const FavoriteWordButton({super.key, required this.word, this.size = 32});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vocabularyAsync = ref.watch(vocabularyListProvider);

    final isInVocabulary = vocabularyAsync.maybeWhen(
      data: (words) => words.any(
        (v) => v.word.trim().toLowerCase() == word.word.trim().toLowerCase(),
      ),
      orElse: () => false,
    );

    return IconButton(
      icon: Icon(
        isInVocabulary ? Icons.star_rounded : Icons.star_outline_rounded,
        color: isInVocabulary ? Colors.amber : Colors.grey,
        size: size,
      ),
      onPressed: () {
        final notifier = ref.read(vocabularyListProvider.notifier);
        if (isInVocabulary) {
          final vocabWord = vocabularyAsync.value!.firstWhere(
            (v) =>
                v.word.trim().toLowerCase() == word.word.trim().toLowerCase(),
          );
          notifier.deleteWord(vocabWord.id);
        } else {
          notifier.addWord(
            word: word.word,
            translation: word.russian,
            transcription: word.transcription,
            languageId: word.languageId,
          );
        }
      },
    );
  }
}
