// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/onboarding/data/models/onboarding_data.dart';
import 'package:wlingo/features/onboarding/domain/page_actions.dart';
import 'package:wlingo/features/onboarding/domain/providers/page/page_provider.dart';
import 'package:wlingo/features/onboarding/presentation/widgets/bottom_onboarding.dart';
import 'package:wlingo/features/onboarding/presentation/widgets/dots.dart';
import 'package:wlingo/features/onboarding/presentation/widgets/onboarding_pageview.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/base_screen.dart';
import 'package:wlingo/widgets/button.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final onboardingData = OnboardingData.getOnboardingData(loc);
    final currentPage = ref.watch(pageProvider);
    final pageController = usePageController(initialPage: currentPage);
    final isDark = Theme.of(context).brightness == Brightness.dark
        ? true
        : false;

    return BaseScreen(
      isDark: isDark,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [AppbarActions(isDark: isDark, padding: 0)],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OnboardinPageview(
                    controller: pageController,
                    items: onboardingData,
                    onPageChanged: (index) {
                      ref.read(pageProvider.notifier).state = index;
                    },
                  ),
                  DotsW(
                    onboardingData: onboardingData,
                    currentPage: currentPage,
                  ),
                  BottomOnboarding(
                    currentPage: currentPage,
                    items: onboardingData,
                  ),
                  const SizedBox(height: 24),
                  Column(
                    spacing: 8,
                    children: [
                      Button(
                        text: onboardingData[currentPage].buttonText,
                        onClicked: () => onNextPressed(
                          context,
                          ref,
                          pageController,
                          currentPage,
                          onboardingData.length,
                        ),
                      ),
                      TextButton(
                        onPressed: () => skipOnboarding(context, ref),
                        child: Text(
                          loc.skipOnboarding,
                          style: ThemeTextStyles.custom(
                            isDark: isDark,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
