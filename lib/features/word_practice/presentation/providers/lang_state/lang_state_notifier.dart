import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/global_variables/services.dart';

class LangStateNotifier extends Notifier<int> {
  @override
  int build() {
    return shared.getInt('lang_cource') ?? 2;
  }

  void setSelectedCourseId(int id) {
    shared.setInt('lang_cource', id);
    state = id;
  }
}
