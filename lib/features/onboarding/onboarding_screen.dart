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
import 'package:wlingo/widgets/button.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final onboardingData = OnboardingData.getOnboardingData(loc);
    final currentPage = ref.watch(pageProvider);
    final pageController = usePageController(initialPage: currentPage);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [AppbarActions(isDark: false)],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OnboardinPageview(
                  controller: pageController,
                  items: onboardingData,
                ),
                DotsW(onboardingData: onboardingData, currentPage: currentPage),
                BottomOnboarding(
                  currentPage: currentPage,
                  items: onboardingData,
                ),
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
                      onPressed: () => skipOnboarding,
                      child: Text(
                        loc.skipOnboarding,
                        style: ThemeTextStyles.custom(
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
      ),
    );
  }
}
