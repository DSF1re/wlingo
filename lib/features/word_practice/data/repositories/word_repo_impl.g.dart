// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_repo_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(wordRepository)
final wordRepositoryProvider = WordRepositoryProvider._();

final class WordRepositoryProvider
    extends $FunctionalProvider<WordRepository, WordRepository, WordRepository>
    with $Provider<WordRepository> {
  WordRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wordRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wordRepositoryHash();

  @$internal
  @override
  $ProviderElement<WordRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WordRepository create(Ref ref) {
    return wordRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WordRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WordRepository>(value),
    );
  }
}

String _$wordRepositoryHash() => r'a5ee44740915c5efd61cac64b6524907619150a9';
