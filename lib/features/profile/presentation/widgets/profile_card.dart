import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/profile/application/certificate_service.dart';
import 'package:wlingo/features/profile/presentation/widgets/edit_profile.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/glass_box.dart';

class ProfileCard extends HookConsumerWidget {
  final UserEntity user;
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

  void _showEditDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditProfileSheet(user: user, loc: loc),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initials =
        '${user.firstName.isNotEmpty ? user.firstName[0] : ''}${user.lastName.isNotEmpty ? user.lastName[0] : ''}'
            .toUpperCase();

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
              _buildAvatar(initials),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: ThemeTextStyles.title1SemiBold(
                        isDark: isDark,
                      ).copyWith(fontSize: 18),
                    ),
                    if (user.middleName != null && user.middleName!.isNotEmpty)
                      Text(
                        user.middleName!,
                        style: TextStyle(
                          fontSize: 13,
                          color: (isDark ? Colors.white : Colors.black)
                              .withValues(alpha: 0.45),
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
          if (user.isAdmin) ...[_buildAdminBadge(), const SizedBox(height: 12)],
          Row(
            children: [
              _buildRatingBadge(),
              const SizedBox(width: 8),
              ratingAsync.when(
                data: (points) {
                  if (points <= 100) return const SizedBox.shrink();
                  return IconButton.filledTonal(
                    onPressed: () => CertificateService.generateAndDownload(
                      userName: '${user.firstName} ${user.lastName}',
                      loc: loc,
                    ),
                    icon: const Icon(Icons.workspace_premium_rounded, size: 20),
                    tooltip: loc.downloadCertificate,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.blue.withValues(
                        alpha: isDark ? 0.15 : 0.12,
                      ),
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String initials) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B7BFE), Color(0xFF7C3AED)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBadge() {
    return ratingAsync.when(
      data: (points) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.amber.withValues(alpha: isDark ? 0.15 : 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
            const SizedBox(width: 4),
            Text(
              '$points',
              style: ThemeTextStyles.regular(color: Colors.amber),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, _) => const Text('—'),
    );
  }

  Widget _buildAdminBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2ED573).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        loc.admin,
        style: ThemeTextStyles.regular(
          color: Color(0xFF2ED573),
        ).copyWith(fontSize: 12),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
