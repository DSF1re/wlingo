import 'package:either_dart/either.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/repositories/user_repository.dart';

class UpdateUserAdminUseCase {
  final UserRepository _repository;

  UpdateUserAdminUseCase(this._repository);

  Future<Either<AppFailure, UserEntity>> call({
    required String userId,
    required String firstName,
    required String lastName,
    String? middleName,
  }) {
    final fName = firstName.trim();
    final lName = lastName.trim();
    final mName = middleName?.trim() ?? '';

    if (fName.isEmpty || lName.isEmpty) {
      return Future.value(Left(AppFailure.fillForm()));
    }

    final nameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ]+$');
    final lastNameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ\s\-]+$');

    if (!nameRegExp.hasMatch(fName) ||
        !lastNameRegExp.hasMatch(lName) ||
        (mName.isNotEmpty && !nameRegExp.hasMatch(mName))) {
      return Future.value(Left(AppFailure.invalidNameFormat()));
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
