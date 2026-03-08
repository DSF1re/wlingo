// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_words_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getWordsUseCase)
final getWordsUseCaseProvider = GetWordsUseCaseProvider._();

final class GetWordsUseCaseProvider
    extends
        $FunctionalProvider<GetWordsUseCase, GetWordsUseCase, GetWordsUseCase>
    with $Provider<GetWordsUseCase> {
  GetWordsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getWordsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getWordsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetWordsUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetWordsUseCase create(Ref ref) {
    return getWordsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetWordsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetWordsUseCase>(value),
    );
  }
}

String _$getWordsUseCaseHash() => r'579e3e7100fc429c532d26ca8abccb764ef529dc';
