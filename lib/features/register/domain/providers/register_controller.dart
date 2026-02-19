import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/features/auth/domain/providers/auth_provider.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() => null;

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String midName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await ref
          .read(authRepositoryProvider)
          .signUp(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            middleName: midName,
            nativeLang: 1,
          );
      return res.fold((fail) => throw fail, (user) => null);
    });
  }
}
