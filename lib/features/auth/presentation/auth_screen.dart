import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failure/auth_failure.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/auth/presentation/providers/auth_controller.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/images.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/base_screen.dart';
import 'package:wlingo/widgets/button.dart';
import 'package:wlingo/widgets/glass_box.dart';
import 'package:wlingo/widgets/input.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final authState = ref.watch(authControllerProvider);

    ref.listen<AsyncValue<UserEntity?>>(authControllerProvider, (prev, next) {
      next.whenOrNull(
        error: (error, _) {
          final msg = error is AuthFailure
              ? error.toLocalizedMessage(loc)
              : error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg)));
        },
        data: (user) {
          if (prev is AsyncLoading && user != null) {
            final role = user.isAdmin ? loc.admin : loc.user;
            final name = '${user.firstName} ${user.lastName}';

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loc.login_as(role, name)),
                backgroundColor: AppColors.successGreen,
              ),
            );
            context.go(Routes.home);
          }
        },
      );
    });

    final showPassword = useState(false);

    return BaseScreen(
      isDark: isDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [AppbarActions(isDark: isDark)],
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GlassBox(
                      padding: const EdgeInsets.all(20),
                      opacity: isDark ? 0.08 : 0.4,
                      blur: 12,
                      borderRadius: BorderRadius.circular(28),
                      color: isDark ? Colors.white : Colors.white,
                      border: Border.all(
                        color: (isDark ? Colors.white : Colors.black)
                            .withValues(alpha: 0.08),
                        width: 1,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppImages.icon, width: 140),
                          const SizedBox(height: 20),
                          Text(
                            loc.promo_auth,
                            textAlign: TextAlign.center,
                            style: ThemeTextStyles.custom(
                              fontSize: 20,
                              isDark: isDark,
                            ),
                          ),
                          const SizedBox(height: 28),
                          Input(
                            controller: emailController,
                            labelText: loc.email,
                          ),
                          const SizedBox(height: 14),
                          Input(
                            controller: passwordController,
                            isObscured: !showPassword.value,
                            labelText: loc.password,
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  showPassword.value = !showPassword.value,
                              icon: Icon(
                                showPassword.value
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                size: 20,
                                color: (isDark ? Colors.white : Colors.black)
                                    .withValues(alpha: 0.35),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Button(
                            isLoading: authState.isLoading,
                            text: loc.login,
                            onClicked: () {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                            },
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => context.go(Routes.register),
                            child: Text(
                              loc.sign_up,
                              style: ThemeTextStyles.regular(isDark: isDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
