import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/bookview/domain/entities/book_entity.dart';
import 'package:wlingo/features/bookview/domain/repositories/book_repository.dart';
import 'package:wlingo/features/bookview/presentation/providers/books_provider.dart';

part 'get_books_usecase.g.dart';

@riverpod
GetBooksUseCase getBooksUseCase(Ref ref) {
  return GetBooksUseCase(ref.watch(bookRepositoryProvider));
}

class GetBooksUseCase {
  final BookRepository _repository;

  GetBooksUseCase(this._repository);

  Future<List<BookEntity>> call(int languageId) {
    return _repository.getBooks(languageId);
  }
}
