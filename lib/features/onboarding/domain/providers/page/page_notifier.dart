import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
  void decrement() => state--;
  int get value => state;
}
