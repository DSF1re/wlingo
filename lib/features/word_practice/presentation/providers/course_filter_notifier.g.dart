// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_filter_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CourseFilterNotifier)
final courseFilterProvider = CourseFilterNotifierProvider._();

final class CourseFilterNotifierProvider
    extends $NotifierProvider<CourseFilterNotifier, CourseFilterState> {
  CourseFilterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'courseFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$courseFilterNotifierHash();

  @$internal
  @override
  CourseFilterNotifier create() => CourseFilterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CourseFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CourseFilterState>(value),
    );
  }
}

String _$courseFilterNotifierHash() =>
    r'fe2967b330cbe57109524722f55fb1ebcb4bba44';

abstract class _$CourseFilterNotifier extends $Notifier<CourseFilterState> {
  CourseFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CourseFilterState, CourseFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CourseFilterState, CourseFilterState>,
              CourseFilterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
