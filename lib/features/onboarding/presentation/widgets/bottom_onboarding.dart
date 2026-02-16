import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wlingo/features/onboarding/data/models/onboarding_data.dart';
import 'package:wlingo/features/onboarding/domain/providers/theme/theme_provider.dart';
import 'package:wlingo/theme/text_styles.dart';

class BottomOnboarding extends ConsumerWidget {
  final List<OnboardingData> items;
  final int currentPage;
  const BottomOnboarding({
    super.key,
    required this.currentPage,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              items[currentPage].title,
              textAlign: TextAlign.center,
              style: ThemeTextStyles.title3SemiBold(isDark: isDark),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                items[currentPage].description,
                textAlign: TextAlign.center,
                style: ThemeTextStyles.regular(isDark: isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
