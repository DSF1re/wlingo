import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/spacing.dart';
import 'package:wlingo/theme/text_styles.dart';

class BottomSheetShell extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isLoading;
  final String? errorMessage;

  const BottomSheetShell({
    super.key,
    required this.title,
    required this.child,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
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
          const SizedBox(height: Spacing.md),
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
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.xxl,
              vertical: Spacing.lg,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: ThemeTextStyles.custom(isDark: isDark, fontSize: 20),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            Flexible(
              child: SingleChildScrollView(
                padding: Spacing.bottomSheet,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: Spacing.lg),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    child,
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
