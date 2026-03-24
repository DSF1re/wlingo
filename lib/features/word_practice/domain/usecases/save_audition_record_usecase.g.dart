// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_audition_record_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
