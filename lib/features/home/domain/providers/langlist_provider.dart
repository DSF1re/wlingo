import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/home/data/models/language.dart';
import 'package:wlingo/features/home/domain/language_list_repository.dart';

final languagesProvider = FutureProvider<List<Language>>((ref) async {
  return LanguageListRepository().getList();
});
