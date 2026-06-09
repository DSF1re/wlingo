import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/home/data/models/language.dart';
import 'package:wlingo/features/home/data/repositories/language_list_repo_impl.dart';
import 'package:wlingo/features/home/domain/language_list_repository.dart';

final languageListRepositoryProvider = Provider<LanguageListRepository>((ref) {
  return SupabaseLanguageListRepository();
});

final languagesProvider = FutureProvider<List<Language>>((ref) async {
  final repo = ref.watch(languageListRepositoryProvider);
  return repo.getList();
});
