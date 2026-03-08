// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_book_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addBookUseCase)
final addBookUseCaseProvider = AddBookUseCaseProvider._();

final class AddBookUseCaseProvider
    extends $FunctionalProvider<AddBookUseCase, AddBookUseCase, AddBookUseCase>
    with $Provider<AddBookUseCase> {
  AddBookUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addBookUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addBookUseCaseHash();

  @$internal
  @override
  $ProviderElement<AddBookUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddBookUseCase create(Ref ref) {
    return addBookUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddBookUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddBookUseCase>(value),
    );
  }
}

String _$addBookUseCaseHash() => r'42dcb1dc6975753c636efac6fdae02aff03bc7c7';
