import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wlingo/core/repositories/book_repository.dart';
import 'package:wlingo/core/repositories/options_repository.dart';
import 'package:wlingo/core/repositories/words_repository.dart';
import '../services/preferences_service.dart';
import 'repositories/auth_repository.dart';
import 'repositories/language_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

final localeNotifier = ValueNotifier(const Locale('en'));
final themeModeNotifier = ValueNotifier(ThemeMode.dark);
final languageNotifier = ValueNotifier<String>('en');

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerSingleton<PreferencesService>(PreferencesService(prefs));

  final supabaseClient = Supabase.instance.client;
  getIt.registerSingleton<SupabaseClient>(supabaseClient);

  getIt.registerSingleton<AuthRepository>(AuthRepository(supabaseClient));

  getIt.registerSingleton<WordsRepository>(
    WordsRepository(supabaseClient, languageNotifier),
  );

  getIt.registerSingleton<LanguageRepository>(
    LanguageRepository(supabaseClient),
  );

  getIt.registerSingleton<OptionsRepository>(
    OptionsRepository(PreferencesService(prefs)),
  );

  getIt.registerSingleton<BooksRepository>(
    BooksRepository(supabaseClient, languageNotifier),
  );
}
