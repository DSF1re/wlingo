import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/bookview/domain/repositories/book_repository.dart';
import 'package:wlingo/features/bookview/presentation/providers/books_provider.dart';

part 'add_book_usecase.g.dart';

@riverpod
AddBookUseCase addBookUseCase(Ref ref) {
  return AddBookUseCase(ref.watch(bookRepositoryProvider));
}

class AddBookUseCase {
  final BookRepository _repository;

  AddBookUseCase(this._repository);

  Future<void> call({
    required String title,
    required String author,
    required String localFilePath,
    required String fileName,
    required int languageId,
  }) {
    return _repository.addBook(
      title: title,
      author: author,
      localFilePath: localFilePath,
      fileName: fileName,
      languageId: languageId,
    );
  }
}
