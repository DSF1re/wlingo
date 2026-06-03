import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'course_filter_notifier.g.dart';

class CourseFilterState {
  final int? levelId;
  final int? categoryId;

  CourseFilterState({this.levelId, this.categoryId});

  CourseFilterState copyWith({int? levelId, int? categoryId}) {
    return CourseFilterState(
      levelId: levelId ?? this.levelId,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}

@riverpod
class CourseFilterNotifier extends _$CourseFilterNotifier {
  @override
  CourseFilterState build() {
    return CourseFilterState();
  }

  void setLevelId(int? id) {
    state = state.copyWith(levelId: id);
  }

  void setCategoryId(int? id) {
    state = state.copyWith(categoryId: id);
  }

  void clearFilters() {
    state = CourseFilterState();
  }
}
