import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/public_vars.dart';
import 'package:wlingo/core/routes.dart';
import 'package:wlingo/features/auth/domain/providers/auth_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/button.dart';
import 'package:wlingo/widgets/input.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark
        ? true
        : false;

    final lastName = useTextEditingController();
    final firstName = useTextEditingController();
    final midName = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    final authRepo = ref.read(authRepositoryProvider);
    var isLoading = useState(false);

    final reg = useCallback(() async {
      isLoading.value = true;
      try {
        final response = await authRepo.signUp(
          email: email.text,
          password: password.text,
          firstName: firstName.text,
          lastName: lastName.text,
          middleName: midName.text,
          nativeLang: 0,
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
    });

    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(actions: [AppbarActions(isDark: isDark)]),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500, maxHeight: 550),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                Button(text: loc.sign_up, onClicked: reg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
