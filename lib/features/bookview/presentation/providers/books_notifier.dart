import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/bookview/domain/entities/book_entity.dart';
import 'package:wlingo/features/bookview/domain/usecases/get_books_usecase.dart';
import 'package:wlingo/core/global_variables/services.dart';

part 'books_notifier.g.dart';

@riverpod
class BooksNotifier extends _$BooksNotifier {
  @override
  FutureOr<List<BookEntity>> build() async {
    return _fetchBooks();
  }

  Future<List<BookEntity>> _fetchBooks() async {
    final langId = shared.getInt('lang_cource') ?? 2;
    final getBooks = ref.read(getBooksUseCaseProvider);
    return getBooks(langId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchBooks());
  }
}
