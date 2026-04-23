import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failure/app_failure.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:wlingo/features/auth/presentation/providers/current_user_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/widgets/user_edit_sheet.dart';

class EditProfileSheet extends ConsumerWidget {
  final UserEntity user;
  final AppLocalizations loc;

  const EditProfileSheet({super.key, required this.user, required this.loc});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserEditSheet(
      user: user,
      loc: loc,
      title: loc.editProfile,
      onSave: (first, last, middle) async {
        final updateProfile = ref.read(updateProfileUseCaseProvider);
        final result = await updateProfile(
          firstName: first,
          lastName: last,
          middleName: middle,
        );

        result.fold((failure) => throw failure.toLocalizedMessage(loc), (
          updatedUser,
        ) {
          ref.invalidate(currentUserProvider);
          if (context.mounted) context.pop();
        });
      },
    );
  }
}
