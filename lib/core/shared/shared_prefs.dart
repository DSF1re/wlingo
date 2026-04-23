import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  Future<void> saveCourseLanguage(int languageId) =>
      _prefs.setInt('lang_course', languageId);

  int getCourseLanguage() => _prefs.getInt('lang_course') ?? _prefs.getInt('lang_cource') ?? 2;

  Future<void> saveLanguage(String languageCode) =>
      _prefs.setString('app_language', languageCode);

  Future<void> saveThemeMode(String themeMode) =>
      _prefs.setString('app_theme_mode', themeMode);

  Future<void> saveOnboardingCompleted(bool value) =>
      _prefs.setBool('onboarding_completed', value);

  String _bookPageKey(String bookId) => 'book_${bookId}_page';

  Future<void> saveBookPage(String bookId, int page) async {
    await _prefs.setInt(_bookPageKey(bookId), page);
  }

  int getBookPage(String bookId) {
    return _prefs.getInt(_bookPageKey(bookId)) ?? 1;
  }
}
