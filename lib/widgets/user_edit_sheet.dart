import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/input_decoration.dart';
import 'package:wlingo/theme/spacing.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/bottom_sheet_shell.dart';
import 'package:wlingo/widgets/gradient_button.dart';

class UserEditSheet extends HookConsumerWidget {
  final UserEntity user;
  final AppLocalizations loc;
  final String title;
  final Future<void> Function(
    String firstName,
    String lastName,
    String middleName,
  )
  onSave;

  const UserEditSheet({
    super.key,
    required this.user,
    required this.loc,
    required this.title,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final firstController = useTextEditingController(text: user.firstName);
    final lastController = useTextEditingController(text: user.lastName);
    final middleController = useTextEditingController(text: user.middleName);

    final errorMessage = useState<String?>(null);
    final isLoading = useState(false);

    Future<void> submit() async {
      if (firstController.text.isEmpty || lastController.text.isEmpty) {
        errorMessage.value = loc.fill_form;
        return;
      }

      isLoading.value = true;
      errorMessage.value = null;

      try {
        await onSave(
          firstController.text,
          lastController.text,
          middleController.text,
        );
      } catch (e) {
        errorMessage.value = e.toString();
      } finally {
        if (context.mounted) {
          isLoading.value = false;
        }
      }
    }

    return BottomSheetShell(
      title: title,
      isLoading: isLoading.value,
      errorMessage: errorMessage.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: firstController,
            style: ThemeTextStyles.regular(isDark: isDark),
            decoration: formInputDecoration(
              label: loc.first_name,
              icon: Icons.person_rounded,
              isDark: isDark,
            ),
          ),
          Spacing.hLg,
          TextField(
            controller: lastController,
            style: ThemeTextStyles.regular(isDark: isDark),
            decoration: formInputDecoration(
              label: loc.last_name,
              icon: Icons.person_outline_rounded,
              isDark: isDark,
            ),
          ),
          Spacing.hLg,
          TextField(
            controller: middleController,
            style: ThemeTextStyles.regular(isDark: isDark),
            decoration: formInputDecoration(
              label: loc.mid_name,
              icon: Icons.badge_rounded,
              isDark: isDark,
            ),
          ),
          Spacing.hXxl,
          GradientButton(
            label: loc.save,
            onTap: submit,
            isLoading: isLoading.value,
          ),
        ],
      ),
    );
  }
}
