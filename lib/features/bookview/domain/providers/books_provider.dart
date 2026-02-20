import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/bookview/data/models/book.dart';
import 'package:wlingo/features/bookview/domain/providers/books_notifier.dart';

final booksNotifierProvider =
    AsyncNotifierProvider.autoDispose<BooksNotifier, List<Book>>(() {
      return BooksNotifier();
    });
