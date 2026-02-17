import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/public_vars.dart';
import 'package:wlingo/core/routes.dart';
import 'package:wlingo/features/auth/domain/providers/auth_provider.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark
        ? true
        : false;
    final loc = AppLocalizations.of(context)!;
    final email = useTextEditingController();
    final password = useTextEditingController();
    final authRepo = ref.read(authRepositoryProvider);
    var isLoading = useState(false);

    final login = useCallback(() async {
      isLoading.value = true;
      try {
        final response = await authRepo.signIn(
          email: email.text.trim(),
          password: password.text,
        );
        if (response.id.isNotEmpty && context.mounted) {
          context.go(Routes.home);
        }
      } catch (e) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(
              'Пользователь не найден или проверьте подключение к сети',
            ),
          ),
        );
      } finally {
        isLoading.value = false;
      }
    }, [authRepo, email, password, isLoading, context]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [AppbarActions(isDark: isDark)],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 32,
              children: [
                Image.asset(AppImages.icon, fit: BoxFit.contain, width: 200),
                Text(
                  loc.promo_auth,
                  style: ThemeTextStyles.custom(fontSize: 24, isDark: isDark),
                ),
                Column(
                  spacing: 16,
                  children: [
                    Input(controller: email, labelText: loc.email),
                    Input(
                      controller: password,
                      isObscured: true,
                      labelText: loc.password,
                    ),
                  ],
                ),
                Column(
                  spacing: 12,
                  children: [
                    Button(
                      isLoading: isLoading.value,
                      text: loc.login,
                      onClicked: login,
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
    );
  }
}
