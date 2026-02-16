import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:wlingo/features/onboarding/data/models/onboarding_data.dart';

class DotsW extends StatelessWidget {
  final List<OnboardingData> onboardingData;
  final int currentPage;
  const DotsW({
    super.key,
    required this.onboardingData,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: onboardingData.length,
      position: currentPage.toDouble(),
      decorator: DotsDecorator(
        size: Size.square(8.0),
        activeSize: Size.square(8.0),
        activeColor: Colors.deepPurpleAccent,
        color: Colors.grey[300]!,
        spacing: EdgeInsets.symmetric(horizontal: 3.5),
      ),
    );
  }
}
