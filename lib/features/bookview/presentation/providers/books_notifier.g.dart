// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BooksNotifier)
final booksProvider = BooksNotifierProvider._();

final class BooksNotifierProvider
    extends $AsyncNotifierProvider<BooksNotifier, List<BookEntity>> {
  BooksNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'booksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$booksNotifierHash();

  @$internal
  @override
  BooksNotifier create() => BooksNotifier();
}

String _$booksNotifierHash() => r'ab214a5a7b0ef5b05ad980a9c10f29b792aa2c98';

abstract class _$BooksNotifier extends $AsyncNotifier<List<BookEntity>> {
  FutureOr<List<BookEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<BookEntity>>, List<BookEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BookEntity>>, List<BookEntity>>,
              AsyncValue<List<BookEntity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
