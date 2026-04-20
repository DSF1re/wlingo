import 'package:either_dart/either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wlingo/core/failure/auth_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/repositories/auth_repository.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_provider.dart';

part 'update_user_admin_usecase.g.dart';

@riverpod
UpdateUserAdminUseCase updateUserAdminUseCase(Ref ref) {
  return UpdateUserAdminUseCase(ref.watch(authRepositoryProvider));
}

class UpdateUserAdminUseCase {
  final AuthRepository _repository;

  UpdateUserAdminUseCase(this._repository);

  Future<Either<AuthFailure, UserEntity>> call({
    required String userId,
    required String firstName,
    required String lastName,
    String? middleName,
  }) {
    final fName = firstName.trim();
    final lName = lastName.trim();
    final mName = middleName?.trim() ?? '';

    if (fName.isEmpty || lName.isEmpty) {
      return Future.value(Left(AuthFailure.fillForm()));
    }

    final nameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ]+$');
    final lastNameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ\s\-]+$');

    if (!nameRegExp.hasMatch(fName) ||
        !lastNameRegExp.hasMatch(lName) ||
        (mName.isNotEmpty && !nameRegExp.hasMatch(mName))) {
      return Future.value(Left(AuthFailure.invalidNameFormat()));
    }

    String capitalizeWord(String word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }

    String capitalizeComplexName(String name) {
      return name.splitMapJoin(
        RegExp(r'[ -]'),
        onMatch: (m) => m.group(0)!,
        onNonMatch: (n) => capitalizeWord(n),
      );
    }

    final formattedFirstName = capitalizeWord(fName);
    final formattedLastName = capitalizeComplexName(lName);
    final formattedMiddleName = mName.isNotEmpty ? capitalizeWord(mName) : null;

    return _repository.updateProfileById(
      userId: userId,
      firstName: formattedFirstName,
      lastName: formattedLastName,
      middleName: formattedMiddleName,
    );
  }
}
