import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/global_variables/services.dart';
import 'package:wlingo/core/shared/shared_prefs.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService(ref.watch(sharedPrefsProvider));
});
