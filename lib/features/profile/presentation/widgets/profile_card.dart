import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/core/global_variables/public_vars.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';
import 'package:wlingo/features/auth/domain/providers/auth_provider.dart';
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

    void showEditDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(loc.editProfile),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstController,
                decoration: InputDecoration(labelText: loc.first_name),
              ),
              TextField(
                controller: lastController,
                decoration: InputDecoration(labelText: loc.last_name),
              ),
              TextField(
                controller: middleController,
                decoration: InputDecoration(labelText: loc.mid_name),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => context.pop(), child: Text(loc.cancel)),
            ElevatedButton(
              onPressed: () async {
                final repository = ref.read(authRepositoryProvider);

                final result = await repository.updateProfile(
                  firstName: firstController.text,
                  lastName: lastController.text,
                  middleName: middleController.text,
                );

                result.fold(
                  (failure) {
                    scaffoldMessengerKey.currentState?.showSnackBar(
                      SnackBar(content: Text(failure.toLocalizedMessage(loc))),
                    );
                  },
                  (user) {
                    if (context.mounted) context.pop();
                  },
                );
              },
              child: Text(loc.save),
            ),
          ],
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
                  '${user.firstName} ${user.lastName} ${user.middleName}',
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
