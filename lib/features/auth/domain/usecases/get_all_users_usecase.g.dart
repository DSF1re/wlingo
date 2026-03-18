// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_users_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAllUsersUseCase)
final getAllUsersUseCaseProvider = GetAllUsersUseCaseProvider._();

final class GetAllUsersUseCaseProvider
    extends
        $FunctionalProvider<
          GetAllUsersUseCase,
          GetAllUsersUseCase,
          GetAllUsersUseCase
        >
    with $Provider<GetAllUsersUseCase> {
  GetAllUsersUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllUsersUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllUsersUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAllUsersUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAllUsersUseCase create(Ref ref) {
    return getAllUsersUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllUsersUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllUsersUseCase>(value),
    );
  }
}

String _$getAllUsersUseCaseHash() =>
    r'c4f96b8ea9ca26bcdb848309d7eabd1d53252819';
