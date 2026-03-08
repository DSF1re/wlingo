// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_books_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getBooksUseCase)
final getBooksUseCaseProvider = GetBooksUseCaseProvider._();

final class GetBooksUseCaseProvider
    extends
        $FunctionalProvider<GetBooksUseCase, GetBooksUseCase, GetBooksUseCase>
    with $Provider<GetBooksUseCase> {
  GetBooksUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBooksUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBooksUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetBooksUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetBooksUseCase create(Ref ref) {
    return getBooksUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBooksUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBooksUseCase>(value),
    );
  }
}

String _$getBooksUseCaseHash() => r'36633c3f373e939824481c641164a8dbc5c0b2b3';
