import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/preferences_service.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/language_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerSingleton<PreferencesService>(PreferencesService(prefs));

  final supabaseClient = Supabase.instance.client;
  getIt.registerSingleton<SupabaseClient>(supabaseClient);

  getIt.registerSingleton<AuthRepository>(AuthRepository(supabaseClient));

  getIt.registerSingleton<LanguageRepository>(
    LanguageRepository(supabaseClient),
  );
}
