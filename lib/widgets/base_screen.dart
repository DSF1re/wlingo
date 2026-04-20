import 'package:flutter/material.dart';
import 'package:wlingo/widgets/gradient_background.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final bool isDark;
  final double maxWidth;
  final bool safeAreaBottom;
  final bool safeAreaTop;
  final PreferredSizeWidget? appBar;

  const BaseScreen({
    super.key,
    required this.child,
    required this.isDark,
    this.maxWidth = 500,
    this.safeAreaBottom = false,
    this.safeAreaTop = true,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: GradientBackground(isDark: isDark, child: const SizedBox.expand()),
          ),
          SafeArea(
            top: safeAreaTop,
            bottom: safeAreaBottom,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
