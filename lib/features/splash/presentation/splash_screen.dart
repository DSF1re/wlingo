import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/splash/domain/providers/splash_provider.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/images.dart';
import 'package:wlingo/theme/text_styles.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashProvider);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.purple,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.icon,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Wlingo',
                  style: ThemeTextStyles.title1SemiBold(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
