import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/theme/app_colors.dart';

class MicrophoneIndicatorButton extends HookConsumerWidget {
  final bool isActive;
  final Future<String> Function() onRecordAndCheck;
  final Future<void> Function()? onStopListen;
  final void Function(bool isActive)? onStateChanged;

  const MicrophoneIndicatorButton({
    super.key,
    required this.isActive,
    required this.onRecordAndCheck,
    this.onStateChanged,
    this.onStopListen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    final scaleAnimation = useAnimation(
      Tween<double>(
        begin: 1.0,
        end: 1.15,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
    );

    useEffect(() {
      if (isActive) {
        controller.repeat(reverse: true);
      } else {
        controller.reverse();
      }
      return null;
    }, [isActive]);

    Future<void> handleTap() async {
      if (isActive) {
        await onStopListen?.call();
        controller.stop();
        controller.reset();
      } else {
        await onRecordAndCheck();
      }
    }

    return GestureDetector(
      onTap: handleTap,
      child: Transform.scale(
        scale: scaleAnimation,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [AppColors.errorRed, AppColors.errorRedDark],
                  )
                : LinearGradient(
                    colors: isDark
                        ? [AppColors.primaryBlue, AppColors.auditionPurple]
                        : [AppColors.primaryBlue, AppColors.primaryBlue],
                  ),
            shape: BoxShape.circle,
            boxShadow: [
              if (isActive)
                BoxShadow(
                  color: AppColors.errorRed.withValues(alpha: 0.5),
                  blurRadius: 28,
                  spreadRadius: 4,
                )
              else
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Icon(
            isActive ? Icons.stop_rounded : Icons.mic_rounded,
            size: 36,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
