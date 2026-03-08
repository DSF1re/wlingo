import 'package:wlingo/features/bookview/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<List<BookEntity>> getBooks(int languageId);
  Future<void> addBook({
    required String title,
    required String author,
    required String localFilePath,
    required String fileName,
    required int languageId,
  });
}
