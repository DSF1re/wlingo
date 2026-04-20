import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failure/auth_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/usecases/update_user_admin_usecase.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/widgets/user_edit_sheet.dart';

class AdminEditUserSheet extends ConsumerWidget {
  final UserEntity user;
  final AppLocalizations loc;

  const AdminEditUserSheet({super.key, required this.user, required this.loc});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserEditSheet(
      user: user,
      loc: loc,
      title: '${loc.editProfile} (${user.firstName})',
      onSave: (first, last, middle) async {
        final updateUserAdmin = ref.read(updateUserAdminUseCaseProvider);
        final result = await updateUserAdmin(
          userId: user.id,
          firstName: first,
          lastName: last,
          middleName: middle,
        );

        result.fold((failure) => throw failure.toLocalizedMessage(loc), (_) {
          if (context.mounted) context.pop();
        });
      },
    );
  }
}
