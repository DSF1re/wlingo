import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:wlingo/models/onboarding.dart';

class DotsW extends StatelessWidget {
  const DotsW({
    super.key,
    required List<OnboardingData> onboardingData,
    required int currentPage,
  }) : _onboardingData = onboardingData,
       _currentPage = currentPage;

  final List<OnboardingData> _onboardingData;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DotsIndicator(
        dotsCount: _onboardingData.length,
        position: _currentPage.toDouble(),
        decorator: DotsDecorator(
          size: Size.square(8.0),
          activeSize: Size.square(8.0),
          activeColor: Colors.deepPurpleAccent,
          color: Colors.grey[300]!,
          spacing: EdgeInsets.symmetric(horizontal: 3.5),
        ),
      ),
    );
  }
}
