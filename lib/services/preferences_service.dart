import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _languageKey = 'app_language';
  static const String _themeModeKey = 'app_theme_mode';

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  Future<void> saveLanguage(String languageCode) =>
      _prefs.setString(_languageKey, languageCode);

  Future<void> saveThemeMode(String themeMode) =>
      _prefs.setString(_themeModeKey, themeMode);

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
