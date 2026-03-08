// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WordsNotifier)
final wordsProvider = WordsNotifierProvider._();

final class WordsNotifierProvider
    extends $AsyncNotifierProvider<WordsNotifier, List<WordEntity>> {
  WordsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wordsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wordsNotifierHash();

  @$internal
  @override
  WordsNotifier create() => WordsNotifier();
}

String _$wordsNotifierHash() => r'023e0325a10b93384428fbfb4116ac0aa50958a7';

abstract class _$WordsNotifier extends $AsyncNotifier<List<WordEntity>> {
  FutureOr<List<WordEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<WordEntity>>, List<WordEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<WordEntity>>, List<WordEntity>>,
              AsyncValue<List<WordEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
