import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/audition_task_view.dart';
import 'package:wlingo/features/word_practice/presentation/widgets/pronunciation_task_view.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/spacing.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/base_screen.dart';

enum TaskType { audition, pronunciation }

class LevelGameScreen extends HookConsumerWidget {
  const LevelGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final tasks = useMemoized(() {
      final random = Random();
      return List.generate(
        5,
        (_) => random.nextBool() ? TaskType.audition : TaskType.pronunciation,
      );
    });

    final currentTaskIndex = useState(0);

    void onNextTask() {
      if (currentTaskIndex.value < tasks.length - 1) {
        currentTaskIndex.value++;
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(Spacing.xxl),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loc.level_completed,
                    style: ThemeTextStyles.title1SemiBold(isDark: isDark),
                  ),
                  Spacing.hMd,
                  Text(
                    loc.level_completed_desc,
                    textAlign: TextAlign.center,
                    style: ThemeTextStyles.regular(
                      isDark: isDark,
                      color: (isDark ? Colors.white : Colors.black)
                          .withValues(alpha: 0.7),
                    ),
                  ),
                  Spacing.hXxl,
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      context.go(Routes.home);
                    },
                    child: Text(
                      loc.ok,
                      style: ThemeTextStyles.title2Heavy(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

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
                Spacing.wMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.level_task_progress(loc.level, currentTaskIndex.value + 1, tasks.length),
                        style: ThemeTextStyles.custom(
                          isDark: isDark,
                          fontSize: 20,
                        ),
                      ),
                      Spacing.hSm,
                      LinearProgressIndicator(
                        value: (currentTaskIndex.value + 1) / tasks.length,
                        backgroundColor: AppColors.primaryBlue.withValues(
                          alpha: 0.2,
                        ),
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.primaryBlue,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: tasks[currentTaskIndex.value] == TaskType.audition
                  ? AuditionTaskView(
                      onNext: onNextTask,
                      key: ValueKey('audition_${currentTaskIndex.value}'),
                    )
                  : PronunciationTaskView(
                      onNext: onNextTask,
                      key: ValueKey('pronounce_${currentTaskIndex.value}'),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
