import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_entity.freezed.dart';

@freezed
sealed class BookEntity with _$BookEntity {
  const factory BookEntity({
    required int id,
    required String title,
    required String author,
    required String url,
    required int languageId,
  }) = _BookEntity;
}
