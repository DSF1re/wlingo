import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class StreakAnimationScreen extends HookWidget {
  final int oldStreak;
  final int newStreak;

  const StreakAnimationScreen({
    super.key,
    required this.oldStreak,
    required this.newStreak,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    final animation = useMemoized(
      () => IntTween(begin: oldStreak, end: newStreak).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOutCubic,
        ),
      ),
      [oldStreak, newStreak],
    );

    final animationValue = useAnimation(animation);

    useEffect(() {
      animationController.forward();
      return null;
    }, const []);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_fire_department_rounded,
                size: 150,
                color: AppColors.orange,
              ),
              const SizedBox(height: 32),
              Text(
                '$animationValue',
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                loc.streakOnFire,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      loc.continueText,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
