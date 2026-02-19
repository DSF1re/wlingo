import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/failture/auth_failture.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/register/domain/providers/register_controller.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/button.dart';
import 'package:wlingo/widgets/input.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    final lastName = useTextEditingController();
    final firstName = useTextEditingController();
    final midName = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();

    ref.listen<AsyncValue<void>>(registerControllerProvider, (prev, next) {
      next.whenOrNull(
        error: (fail, _) {
          final msg = fail is AuthFailure
              ? fail.toLocalizedMessage(loc)
              : fail.toString();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg)));
        },
        data: (_) {
          if (prev is AsyncLoading) context.go(Routes.home);
        },
      );
    });

    final isLoading = ref.watch(registerControllerProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go(Routes.login),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [AppbarActions(isDark: isDark)],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 24,
                children: [
                  Text(
                    loc.sign_up,
                    style: ThemeTextStyles.title1ExtraBold(isDark: isDark),
                  ),
                  Column(
                    spacing: 12,
                    children: [
                      Input(controller: lastName, labelText: loc.last_name),
                      Input(controller: firstName, labelText: loc.first_name),
                      Input(controller: midName, labelText: loc.mid_name),
                      Input(controller: email, labelText: loc.email),
                      Input(
                        controller: password,
                        labelText: loc.password,
                        isObscured: true,
                      ),
                    ],
                  ),
                  Button(
                    isLoading: isLoading,
                    text: loc.sign_up,
                    onClicked: () {
                      ref
                          .read(registerControllerProvider.notifier)
                          .register(
                            email: email.text.trim(),
                            password: password.text,
                            firstName: firstName.text.trim(),
                            lastName: lastName.text.trim(),
                            midName: midName.text.trim(),
                          );
                    },
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
