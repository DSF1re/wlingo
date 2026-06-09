import 'package:wlingo/features/bookview/domain/repositories/book_repository.dart';

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
