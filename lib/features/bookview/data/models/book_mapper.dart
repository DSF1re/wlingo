import 'package:wlingo/features/bookview/domain/entities/book_entity.dart';
import 'package:wlingo/features/bookview/data/models/book.dart';

extension BookModelX on Book {
  BookEntity toEntity() {
    return BookEntity(
      id: id,
      title: title,
      author: author,
      url: url,
      languageId: languageId,
    );
  }
}
