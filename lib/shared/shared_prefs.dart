import 'package:wlingo/main.dart';

class PreferencesService {
  PreferencesService();
  Future<void> saveCourseLanguage(int languageId) =>
      shared.setInt('lang_cource', languageId);

  int getCourseLanguage() => shared.getInt('lang_cource') ?? 2;
  Future<void> saveLanguage(String languageCode) =>
      shared.setString('app_language', languageCode);

  Future<void> saveThemeMode(String themeMode) =>
      shared.setString('app_theme_mode', themeMode);

  Future<void> saveOnboardingCompleted(bool value) =>
      shared.setBool('onboarding_completed', value);

  String _bookPageKey(String bookId) => 'book_${bookId}_page';

  Future<void> saveBookPage(String bookId, int page) async {
    await shared.setInt(_bookPageKey(bookId), page);
  }

  int getBookPage(String bookId) {
    return shared.getInt(_bookPageKey(bookId)) ?? 1;
  }
}
