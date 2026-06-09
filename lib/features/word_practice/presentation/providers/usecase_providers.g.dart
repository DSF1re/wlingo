// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usecase_providers.dart';

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

@ProviderFor(saveAuditionRecordUseCase)
final saveAuditionRecordUseCaseProvider = SaveAuditionRecordUseCaseProvider._();

final class SaveAuditionRecordUseCaseProvider
    extends
        $FunctionalProvider<
          SaveAuditionRecordUseCase,
          SaveAuditionRecordUseCase,
          SaveAuditionRecordUseCase
        >
    with $Provider<SaveAuditionRecordUseCase> {
  SaveAuditionRecordUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveAuditionRecordUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveAuditionRecordUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveAuditionRecordUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveAuditionRecordUseCase create(Ref ref) {
    return saveAuditionRecordUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveAuditionRecordUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveAuditionRecordUseCase>(value),
    );
  }
}

String _$saveAuditionRecordUseCaseHash() =>
    r'5ae85e43b77e054452c8dbbaddd474cf1967e9b4';
