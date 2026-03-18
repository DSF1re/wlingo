// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_admin_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateUserAdminUseCase)
final updateUserAdminUseCaseProvider = UpdateUserAdminUseCaseProvider._();

final class UpdateUserAdminUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateUserAdminUseCase,
          UpdateUserAdminUseCase,
          UpdateUserAdminUseCase
        >
    with $Provider<UpdateUserAdminUseCase> {
  UpdateUserAdminUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateUserAdminUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateUserAdminUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateUserAdminUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateUserAdminUseCase create(Ref ref) {
    return updateUserAdminUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateUserAdminUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateUserAdminUseCase>(value),
    );
  }
}

String _$updateUserAdminUseCaseHash() =>
    r'12d37f29dc737821e2a53bdca901ccc51b214fd2';
