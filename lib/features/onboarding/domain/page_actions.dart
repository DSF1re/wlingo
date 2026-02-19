// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/onboarding/domain/providers/page/page_provider.dart';
import 'package:wlingo/main.dart';

void onNextPressed(
  BuildContext context,
  WidgetRef ref,
  PageController controller,
  int currentPage,
  int totalPages,
) {
  if (currentPage < totalPages - 1) {
    final nextPage = currentPage + 1;
    ref.read(pageProvider.notifier).state = nextPage;
    controller.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  } else {
    skipOnboarding(context);
  }
}

void skipOnboarding(BuildContext context) {
  shared.setBool('onboarding_completed', true);
  context.go(Routes.login);
}
