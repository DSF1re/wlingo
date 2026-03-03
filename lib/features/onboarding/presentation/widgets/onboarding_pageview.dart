import 'package:flutter/material.dart';
import 'package:wlingo/features/onboarding/data/models/onboarding_data.dart';

class OnboardinPageview extends StatelessWidget {
  final PageController controller;
  final List<OnboardingData> items;
  final double aspectRatio;
  final ValueChanged<int>? onPageChanged;

  const OnboardinPageview({
    super.key,
    required this.controller,
    required this.items,
    this.onPageChanged,
    this.aspectRatio = 0.9,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: PageView.builder(
          controller: controller,
          itemCount: items.length,
          onPageChanged: onPageChanged,
          itemBuilder: (context, index) => Center(
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Image.asset(items[index].imagePath, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
