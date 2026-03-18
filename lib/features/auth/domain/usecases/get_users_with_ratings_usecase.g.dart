// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users_with_ratings_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getUsersWithRatingsUseCase)
final getUsersWithRatingsUseCaseProvider =
    GetUsersWithRatingsUseCaseProvider._();

final class GetUsersWithRatingsUseCaseProvider
    extends
        $FunctionalProvider<
          GetUsersWithRatingsUseCase,
          GetUsersWithRatingsUseCase,
          GetUsersWithRatingsUseCase
        >
    with $Provider<GetUsersWithRatingsUseCase> {
  GetUsersWithRatingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUsersWithRatingsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUsersWithRatingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetUsersWithRatingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUsersWithRatingsUseCase create(Ref ref) {
    return getUsersWithRatingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUsersWithRatingsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUsersWithRatingsUseCase>(value),
    );
  }
}

String _$getUsersWithRatingsUseCaseHash() =>
    r'19432f99455f3e1647740fe5fdf041d57e9a049c';
