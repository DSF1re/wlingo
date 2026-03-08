// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_book_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddBookNotifier)
final addBookProvider = AddBookNotifierProvider._();

final class AddBookNotifierProvider
    extends $AsyncNotifierProvider<AddBookNotifier, void> {
  AddBookNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addBookProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addBookNotifierHash();

  @$internal
  @override
  AddBookNotifier create() => AddBookNotifier();
}

String _$addBookNotifierHash() => r'09ecb3fd55b65bda0e89e32ba5182a7ce7c9c619';

abstract class _$AddBookNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
