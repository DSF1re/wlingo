// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_word_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddWordNotifier)
final addWordProvider = AddWordNotifierProvider._();

final class AddWordNotifierProvider
    extends $AsyncNotifierProvider<AddWordNotifier, void> {
  AddWordNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addWordProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addWordNotifierHash();

  @$internal
  @override
  AddWordNotifier create() => AddWordNotifier();
}

String _$addWordNotifierHash() => r'3c5f9cda2fce099b0039e9840a9aa96c2e9cbaa3';

abstract class _$AddWordNotifier extends $AsyncNotifier<void> {
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
