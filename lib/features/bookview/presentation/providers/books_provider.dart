import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/features/bookview/domain/repositories/book_repository.dart';
import 'package:wlingo/features/bookview/data/repositories/book_repo_impl.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return SupabaseBookRepository();
});
