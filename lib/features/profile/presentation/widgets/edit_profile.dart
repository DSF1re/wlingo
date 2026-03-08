import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:wlingo/features/auth/presentation/providers/current_user_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class EditProfileDialog extends HookConsumerWidget {
  final UserEntity user;
  final AppLocalizations loc;

  const EditProfileDialog({super.key, required this.user, required this.loc});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstController = useTextEditingController(text: user.firstName);
    final lastController = useTextEditingController(text: user.lastName);
    final middleController = useTextEditingController(text: user.middleName);

    useValueChanged<UserEntity, void>(user, (_, _) {
      firstController.text = user.firstName;
      lastController.text = user.lastName;
      middleController.text = user.middleName ?? '';
    });

    final errorMessage = useState<String?>(null);
    final isLoading = useState(false);

    return AlertDialog(
      title: Text(loc.editProfile),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (errorMessage.value != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                errorMessage.value!,
                style: const TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
          TextField(
            controller: firstController,
            enabled: !isLoading.value,
            decoration: InputDecoration(labelText: loc.first_name),
          ),
          TextField(
            controller: lastController,
            enabled: !isLoading.value,
            decoration: InputDecoration(labelText: loc.last_name),
          ),
          TextField(
            controller: middleController,
            enabled: !isLoading.value,
            decoration: InputDecoration(labelText: loc.mid_name),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading.value ? null : () => context.pop(),
          child: Text(loc.cancel),
        ),
        ElevatedButton(
          onPressed: isLoading.value
              ? null
              : () async {
                  isLoading.value = true;
                  errorMessage.value = null;

                  final updateProfile = ref.read(updateProfileUseCaseProvider);
                  final result = await updateProfile(
                    firstName: firstController.text,
                    lastName: lastController.text,
                    middleName: middleController.text,
                  );

                  result.fold(
                    (failure) {
                      isLoading.value = false;
                      errorMessage.value = failure.toLocalizedMessage(loc);
                    },
                    (updatedUser) {
                      ref.invalidate(currentUserProvider);
                      if (context.mounted) context.pop();
                    },
                  );
                },
          child: isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(loc.save),
        ),
      ],
    );
  }
}
