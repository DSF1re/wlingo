import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/admin/application/admin_report_service.dart';
import 'package:wlingo/features/admin/presentation/widgets/admin_edit_user_sheet.dart';
import 'package:wlingo/features/auth/domain/usecases/get_all_users_usecase.dart';
import 'package:wlingo/features/auth/domain/usecases/get_users_with_ratings_usecase.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/base_screen.dart';

class AdminUsersScreen extends HookConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    useEffect(() {
      searchController.addListener(() {
        searchQuery.value = searchController.text.toLowerCase();
      });
      return null;
    }, [searchController]);

    return BaseScreen(
      isDark: isDark,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go(Routes.home),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    loc.users,
                    style: ThemeTextStyles.title1ExtraBold(isDark: isDark),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final reportData = await ref.read(getUsersWithRatingsUseCaseProvider).call();
                    reportData.fold(
                      (failure) => null, // Handle error if needed
                      (data) => AdminReportService.generateUserStatsReport(
                        userData: data,
                        loc: loc,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.analytics_outlined,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  tooltip: loc.statistics,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              controller: searchController,
              style: ThemeTextStyles.regular(isDark: isDark),
              decoration: InputDecoration(
                hintText: loc.ask_somethink,
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: 0.05,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: ref.read(getAllUsersUseCaseProvider).call(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('${loc.error}: ${snapshot.error}'));
                }
                final result = snapshot.data;
                if (result == null) return const SizedBox();

                return result.fold(
                  (failure) => Center(child: Text(loc.error)),
                  (users) {
                    final filteredUsers = users.where((u) {
                      final fullName =
                          '${u.firstName} ${u.lastName} ${u.middleName ?? ''}'
                              .toLowerCase();
                      return fullName.contains(searchQuery.value);
                    }).toList();

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: (isDark ? Colors.white : Colors.black)
                                .withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: const Color(
                                0xFF6B8EFF,
                              ).withValues(alpha: 0.2),
                              child: Text(
                                user.firstName[0],
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                            title: Text(
                              '${user.firstName} ${user.lastName}',
                              style: ThemeTextStyles.title3SemiBold(
                                isDark: isDark,
                              ),
                            ),
                            subtitle: Text(
                              user.isAdmin ? loc.admin : loc.user,
                              style: ThemeTextStyles.caption(
                                isDark: isDark,
                                color: (isDark ? Colors.white : Colors.black)
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                            trailing: const Icon(Icons.edit_note_rounded),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    AdminEditUserSheet(user: user, loc: loc),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
