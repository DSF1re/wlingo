import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/bookview/domain/repositories/book_repository.dart';
import 'package:wlingo/features/bookview/data/repositories/book_repo_impl.dart';

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return SupabaseBookRepository();
});
