// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audition_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuditionNotifier)
final auditionNotifierProvider = AuditionNotifierProvider._();

final class AuditionNotifierProvider
    extends $AsyncNotifierProvider<AuditionNotifier, List<WordEntity>> {
  AuditionNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditionNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditionNotifierHash();

  @$internal
  @override
  AuditionNotifier create() => AuditionNotifier();
}

String _$auditionNotifierHash() => r'b395702b7443c38d4601ddc7f42b43c521a30c14';

abstract class _$AuditionNotifier extends $AsyncNotifier<List<WordEntity>> {
  FutureOr<List<WordEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<WordEntity>>, List<WordEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<WordEntity>>, List<WordEntity>>,
              AsyncValue<List<WordEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
