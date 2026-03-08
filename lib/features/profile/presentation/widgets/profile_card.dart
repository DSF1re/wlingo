import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';
import 'package:wlingo/features/auth/domain/providers/auth_provider.dart';
import 'package:wlingo/features/auth/domain/providers/current_user_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';

class ProfileCard extends HookConsumerWidget {
  final User user;
  final AsyncValue<int> ratingAsync;
  final bool isDark;
  final AppLocalizations loc;

  const ProfileCard({
    super.key,
    required this.user,
    required this.ratingAsync,
    required this.isDark,
    required this.loc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstController = useTextEditingController(text: user.firstName);
    final lastController = useTextEditingController(text: user.lastName);
    final middleController = useTextEditingController(text: user.middleName);

    useValueChanged<User, void>(user, (_, _) {
      firstController.text = user.firstName;
      lastController.text = user.lastName;
      middleController.text = user.middleName ?? '';
    });

    void showEditDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => HookBuilder(
          builder: (dialogContext) {
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
                  onPressed: isLoading.value ? null : () => dialogContext.pop(),
                  child: Text(loc.cancel),
                ),
                ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : () async {
                          isLoading.value = true;
                          errorMessage.value = null;

                          final repository = ref.read(authRepositoryProvider);
                          final result = await repository.updateProfile(
                            firstName: firstController.text,
                            lastName: lastController.text,
                            middleName: middleController.text,
                          );

                          result.fold(
                            (failure) {
                              isLoading.value = false;
                              errorMessage.value = failure.toLocalizedMessage(
                                loc,
                              );
                            },
                            (updatedUser) {
                              ref.invalidate(currentUserProvider);
                              if (dialogContext.mounted) dialogContext.pop();
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
          },
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${user.firstName} ${user.lastName} ${user.middleName ?? ''}',
                  style: ThemeTextStyles.title1SemiBold(isDark: isDark),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                onPressed: () => showEditDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ratingAsync.when(
            data: (points) => Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${loc.rating}: $points',
                  style: ThemeTextStyles.regular(isDark: isDark),
                ),
              ],
            ),
            loading: () => const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            error: (_, _) => const Text('—'),
          ),
          if (user.isAdmin) ...[
            const SizedBox(height: 8),
            Chip(label: Text(loc.admin)),
          ],
        ],
      ),
    );
  }
}
