import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/profile/presentation/widgets/profile_card.dart';
import 'package:wlingo/theme/spacing.dart';

class ProfileHeaderSection extends ConsumerWidget {
  final dynamic user;
  final bool isDark;
  final dynamic loc;

  const ProfileHeaderSection({
    super.key,
    required this.user,
    required this.isDark,
    required this.loc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(
              user: user,
              isDark: isDark,
              loc: loc,
            ),
            Spacing.hXxl,
            Text(
              (user.isAdmin
                      ? (loc.registration as String)
                      : (loc.history as String))
                  .toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: 0.35,
                ),
              ),
            ),
            Spacing.hMd,
          ],
        ),
      ),
    );
  }
}
