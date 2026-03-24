import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';

extension UserModelX on User {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      nativeLang: nativeLang,
      isAdmin: isAdmin,
      createdAt: createdAt,
    );
  }
}
