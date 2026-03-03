import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          decoration: BoxDecoration(
            color: isActive ? Colors.redAccent : Colors.grey[300],
            shape: BoxShape.circle,
            boxShadow: [
              if (isActive)
                BoxShadow(
                  color: Colors.redAccent.withValues(alpha: 0.6),
                  blurRadius: 32,
                  spreadRadius: 6,
                ),
            ],
          ),
          padding: const EdgeInsets.all(18),
          child: Icon(
            Icons.mic,
            size: 38,
            color: isActive ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
