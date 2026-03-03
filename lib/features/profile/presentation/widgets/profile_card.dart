import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/auth/data/models/user/user.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';

class ProfileCard extends StatelessWidget {
  final User user;
  final AsyncValue<int> ratingAsync;
  final bool isDark;
  final AppLocalizations loc;

  const ProfileCard({
    super.key,
    required this.user,
    required this.ratingAsync,
    required this.isDark,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${user.firstName} ${user.lastName}',
            style: ThemeTextStyles.title1SemiBold(isDark: isDark),
          ),
          const SizedBox(height: 8),
          ratingAsync.when(
            data: (points) => Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${loc.rating}: $points',
                  style: ThemeTextStyles.regular(isDark: isDark),
                ),
              ],
            ),
            loading: () => const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            error: (_, _) => const Text('—'),
          ),
          if (user.isAdmin) ...[
            const SizedBox(height: 8),
            Chip(label: Text(loc.admin)),
          ],
        ],
      ),
    );
  }
}
