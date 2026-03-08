// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_word_practice_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveWordPracticeUseCase)
final saveWordPracticeUseCaseProvider = SaveWordPracticeUseCaseProvider._();

final class SaveWordPracticeUseCaseProvider
    extends
        $FunctionalProvider<
          SaveWordPracticeUseCase,
          SaveWordPracticeUseCase,
          SaveWordPracticeUseCase
        >
    with $Provider<SaveWordPracticeUseCase> {
  SaveWordPracticeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveWordPracticeUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveWordPracticeUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveWordPracticeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveWordPracticeUseCase create(Ref ref) {
    return saveWordPracticeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveWordPracticeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveWordPracticeUseCase>(value),
    );
  }
}

String _$saveWordPracticeUseCaseHash() =>
    r'd93e122cb806ce6e3718966d82268f502a36e5fa';
