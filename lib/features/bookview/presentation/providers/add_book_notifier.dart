import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/bookview/domain/usecases/add_book_usecase.dart';

part 'add_book_notifier.g.dart';

@riverpod
class AddBookNotifier extends _$AddBookNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> addBook({
    required String title,
    required String author,
    required String filePath,
    required String fileName,
    required int languageId,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final uploadUseCase = ref.read(addBookUseCaseProvider);

      await uploadUseCase(
        title: title,
        author: author,
        localFilePath: filePath,
        fileName: fileName,
        languageId: languageId,
      );
    });
  }
}
