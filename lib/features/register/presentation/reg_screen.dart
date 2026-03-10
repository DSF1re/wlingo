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
import 'package:wlingo/widgets/base_screen.dart';
import 'package:wlingo/widgets/button.dart';
import 'package:wlingo/widgets/glass_box.dart';
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

    return BaseScreen(
      isDark: isDark,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go(Routes.login),
                  child: Icon(Icons.arrow_back_rounded),
                ),
                const Spacer(),
                AppbarActions(isDark: isDark, padding: 0),
              ],
            ),
          ),
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
                          Text(
                            loc.sign_up,
                            style: ThemeTextStyles.title1ExtraBold(
                              isDark: isDark,
                            ).copyWith(fontSize: 26, letterSpacing: -0.5),
                          ),
                          const SizedBox(height: 24),
                          Input(controller: lastName, labelText: loc.last_name),
                          const SizedBox(height: 12),
                          Input(
                            controller: firstName,
                            labelText: loc.first_name,
                          ),
                          const SizedBox(height: 12),
                          Input(controller: midName, labelText: loc.mid_name),
                          const SizedBox(height: 12),
                          Input(controller: email, labelText: loc.email),
                          const SizedBox(height: 12),
                          Input(
                            controller: password,
                            labelText: loc.password,
                            isObscured: true,
                          ),
                          const SizedBox(height: 24),
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
            ),
          ),
        ],
      ),
    );
  }
}
