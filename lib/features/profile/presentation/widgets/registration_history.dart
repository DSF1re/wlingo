import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wlingo/features/auth/domain/usecases/get_all_users_usecase.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';

class RegistrationHistorySection extends ConsumerWidget {
  final bool isDark;
  final AppLocalizations loc;

  const RegistrationHistorySection({
    super.key,
    required this.isDark,
    required this.loc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(getAllUsersUseCaseProvider).call();

    return FutureBuilder(
      future: usersAsync,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text('${loc.error}: ${snapshot.error}')),
          );
        }
        final result = snapshot.data;
        if (result == null) return const SliverToBoxAdapter(child: SizedBox());

        return result.fold(
          (failure) => SliverToBoxAdapter(
            child: Center(child: Text(loc.error)),
          ),
          (users) {
            if (users.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(child: Text(loc.usr_not_found)),
              );
            }

            // Sort by date descending
            users.sort((a, b) => (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final user = users[index];
                    final fullName = '${user.firstName} ${user.lastName}';
                    final dateStr = user.createdAt != null
                        ? DateFormat('dd.MM.yyyy').format(user.createdAt!)
                        : '—';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: (isDark ? Colors.white : Colors.black)
                            .withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        title: Text(
                          fullName,
                          style: ThemeTextStyles.regular(
                            isDark: isDark,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        trailing: Text(
                          dateStr,
                          style: ThemeTextStyles.caption(
                            isDark: isDark,
                            color: (isDark ? Colors.white : Colors.black)
                                .withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: users.length,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
