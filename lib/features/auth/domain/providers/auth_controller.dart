import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/auth/domain/providers/auth_provider.dart';
part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    final authRepo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final result = await authRepo.signIn(email: email, password: password);
      return result.fold(
        (failure) => throw failure, // Пробрасываем ошибку в AsyncValue
        (user) => null,
      );
    });
  }
}
