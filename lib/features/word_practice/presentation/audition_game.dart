import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/audition_task_view.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/base_screen.dart';

class AuditionGameScreen extends HookWidget {
  const AuditionGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final taskKey = useState(UniqueKey());

    return BaseScreen(
      isDark: isDark,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go(Routes.home),
                  child: const Icon(Icons.arrow_back_rounded),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    loc.audition,
                    style: ThemeTextStyles.custom(isDark: isDark, fontSize: 20),
                  ),
                ),
                AppbarActions(isDark: isDark, padding: 0),
              ],
            ),
          ),
          Expanded(
            child: AuditionTaskView(
              key: taskKey.value,
              onNext: () {
                taskKey.value = UniqueKey();
              },
            ),
          ),
        ],
      ),
    );
  }
}
