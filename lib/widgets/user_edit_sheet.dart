import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';

class UserEditSheet extends HookConsumerWidget {
  final UserEntity user;
  final AppLocalizations loc;
  final String title;
  final Future<void> Function(
    String firstName,
    String lastName,
    String middleName,
  ) onSave;

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

    InputDecoration inputDecoration({
      String? label,
      required IconData icon,
      required bool isDark,
    }) {
      return InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          size: 20,
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: (isDark ? Colors.white : Colors.black).withValues(
          alpha: 0.03,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primaryBlueLight.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        labelStyle: ThemeTextStyles.caption(
          isDark: isDark,
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      );
    }

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

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF121212) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.15,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: ThemeTextStyles.title1SemiBold(isDark: isDark),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (errorMessage.value != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        errorMessage.value!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  TextField(
                    controller: firstController,
                    style: ThemeTextStyles.regular(isDark: isDark),
                    decoration: inputDecoration(
                      label: loc.first_name,
                      icon: Icons.person_rounded,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: lastController,
                    style: ThemeTextStyles.regular(isDark: isDark),
                    decoration: inputDecoration(
                      label: loc.last_name,
                      icon: Icons.person_outline_rounded,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: middleController,
                    style: ThemeTextStyles.regular(isDark: isDark),
                    decoration: inputDecoration(
                      label: loc.mid_name,
                      icon: Icons.badge_rounded,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Bounceable(
                    onTap: isLoading.value ? null : submit,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryBlueLight,
                            AppColors.primaryBlueLighter,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryBlueLight.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: isLoading.value
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              loc.save,
                              style: ThemeTextStyles.title2Heavy(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
