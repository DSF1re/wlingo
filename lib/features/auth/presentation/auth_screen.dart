import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/auth/domain/providers/auth_controller.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/images.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/button.dart';
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

    ref.listen<AsyncValue<void>>(authControllerProvider, (prev, next) {
      next.whenOrNull(
        error: (error, _) {
          final msg = error is AuthFailure
              ? error.toLocalizedMessage(loc)
              : error.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg)));
        },
        data: (_) {
          if (prev is AsyncLoading) context.go(Routes.home);
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [AppbarActions(isDark: isDark)],
      ),
      body: Center(
        child: SingleChildScrollView(
          // Важно, чтобы не было overflow при появлении клавиатуры
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 32,
                children: [
                  Image.asset(AppImages.icon, width: 200),
                  Text(
                    loc.promo_auth,
                    style: ThemeTextStyles.custom(fontSize: 24, isDark: isDark),
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      Input(controller: emailController, labelText: loc.email),
                      Input(
                        controller: passwordController,
                        isObscured: true,
                        labelText: loc.password,
                      ),
                    ],
                  ),
                  Column(
                    spacing: 12,
                    children: [
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
                      TextButton(
                        onPressed: () => context.go(Routes.register),
                        child: Text(
                          loc.sign_up,
                          style: ThemeTextStyles.regular(isDark: isDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
