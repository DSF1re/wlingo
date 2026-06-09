import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/bookview/domain/usecases/add_book_usecase.dart';
import 'package:wlingo/features/bookview/domain/usecases/get_books_usecase.dart';
import 'package:wlingo/features/bookview/presentation/providers/books_provider.dart';

part 'usecase_providers.g.dart';

@riverpod
GetBooksUseCase getBooksUseCase(Ref ref) {
  return GetBooksUseCase(ref.watch(bookRepositoryProvider));
}

@riverpod
AddBookUseCase addBookUseCase(Ref ref) {
  return AddBookUseCase(ref.watch(bookRepositoryProvider));
}
