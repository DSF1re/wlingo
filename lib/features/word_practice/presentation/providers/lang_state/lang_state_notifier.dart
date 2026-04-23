import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/shared/shared_provider.dart';

class LangStateNotifier extends Notifier<int> {
  @override
  int build() {
    return ref.read(preferencesServiceProvider).getCourseLanguage();
  }

  void setSelectedCourseId(int id) {
    ref.read(preferencesServiceProvider).saveCourseLanguage(id);
    state = id;
  }
}
