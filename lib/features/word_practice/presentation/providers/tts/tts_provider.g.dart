// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tts)
final ttsProvider = TtsProvider._();

final class TtsProvider
    extends $FunctionalProvider<FlutterTts, FlutterTts, FlutterTts>
    with $Provider<FlutterTts> {
  TtsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ttsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ttsHash();

  @$internal
  @override
  $ProviderElement<FlutterTts> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlutterTts create(Ref ref) {
    return tts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterTts value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterTts>(value),
    );
  }
}

String _$ttsHash() => r'6c91efd11e6f2952538747724901a34296371b49';

@ProviderFor(TtsNotifier)
final ttsNotifierProvider = TtsNotifierProvider._();

final class TtsNotifierProvider
    extends $AsyncNotifierProvider<TtsNotifier, void> {
  TtsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ttsNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ttsNotifierHash();

  @$internal
  @override
  TtsNotifier create() => TtsNotifier();
}

String _$ttsNotifierHash() => r'551fab3360226092ad825c88ff89fbc8dbfd0bea';

abstract class _$TtsNotifier extends $AsyncNotifier<void> {
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
