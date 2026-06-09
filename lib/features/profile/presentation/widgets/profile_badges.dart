import 'package:flutter/material.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class StreakBadge extends StatelessWidget {
  final UserEntity user;
  final bool isDark;

  const StreakBadge({super.key, required this.user, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: isDark ? 0.15 : 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 16),
          const SizedBox(width: 4),
          Text('${user.streak}', style: ThemeTextStyles.regular(color: Colors.orange)),
        ],
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final int points;
  final bool isDark;

  const RatingBadge({super.key, required this.points, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: isDark ? 0.15 : 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text('$points', style: ThemeTextStyles.regular(color: Colors.amber)),
        ],
      ),
    );
  }
}

class AdminBadge extends StatelessWidget {
  final bool isDark;
  final AppLocalizations loc;

  const AdminBadge({super.key, required this.isDark, required this.loc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.successGreen.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        loc.admin,
        style: ThemeTextStyles.regular(color: AppColors.successGreen).copyWith(fontSize: 12),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
