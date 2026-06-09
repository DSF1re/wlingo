import 'package:wlingo/features/bookview/domain/entities/book_entity.dart';
import 'package:wlingo/features/bookview/domain/repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository _repository;

  GetBooksUseCase(this._repository);

  Future<List<BookEntity>> call(int languageId) {
    return _repository.getBooks(languageId);
  }
}
