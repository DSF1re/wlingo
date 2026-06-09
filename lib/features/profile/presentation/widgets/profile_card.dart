import 'package:flutter/material.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/profile/presentation/widgets/certificate_button.dart';
import 'package:wlingo/features/profile/presentation/widgets/edit_profile.dart';
import 'package:wlingo/features/profile/presentation/widgets/profile_badges.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/glass_box.dart';

class ProfileCard extends StatelessWidget {
  final UserEntity user;
  final bool isDark;
  final AppLocalizations loc;

  const ProfileCard({
    super.key,
    required this.user,
    required this.isDark,
    required this.loc,
  });

  void _showEditDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditProfileSheet(user: user, loc: loc),
    );
  }

  String _initials() {
    final first = user.firstName.isNotEmpty ? user.firstName[0] : '';
    final last = user.lastName.isNotEmpty ? user.lastName[0] : '';
    return '$first$last'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GlassBox(
      padding: const EdgeInsets.all(16),
      opacity: isDark ? 0.08 : 0.35,
      blur: 10,
      borderRadius: BorderRadius.circular(20),
      color: isDark ? Colors.white : Colors.white,
      border: Border.all(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08),
        width: 1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Avatar(initials: _initials()),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: ThemeTextStyles.title1SemiBold(isDark: isDark).copyWith(fontSize: 18),
                    ),
                    if (user.middleName != null && user.middleName!.isNotEmpty)
                      Text(
                        user.middleName!,
                        style: TextStyle(
                          fontSize: 13,
                          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.45),
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: isDark ? Colors.white54 : Colors.black38,
                ),
                onPressed: () => _showEditDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (user.isAdmin) ...[AdminBadge(isDark: isDark, loc: loc), const SizedBox(height: 12)],
          if (!user.isAdmin)
            Row(
              children: [
                StreakBadge(user: user, isDark: isDark),
                const SizedBox(width: 8),
                RatingBadge(points: user.xp, isDark: isDark),
                const SizedBox(width: 8),
                CertificateDownloadButton(user: user, isDark: isDark, loc: loc),
              ],
            ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;

  const _Avatar({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primaryBlue, AppColors.auditionPurple]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
