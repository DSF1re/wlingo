import 'package:wlingo/features/home/data/models/language.dart';

abstract class LanguageListRepository {
  Future<List<Language>> getList();
}

