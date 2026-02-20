import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/shared/shared_prefs.dart';

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});
