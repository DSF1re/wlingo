import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/core/shared/shared_provider.dart';
import 'package:wlingo/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:wlingo/features/auth/presentation/providers/current_user_provider.dart';
import 'package:wlingo/features/bookview/presentation/screens/add_book_screen.dart';
import 'package:wlingo/features/home/domain/providers/langlist_provider.dart';
import 'package:wlingo/features/home/presentation/widgets/lang_dropdown.dart';
import 'package:wlingo/features/home/presentation/widgets/menu_tile.dart';
import 'package:wlingo/features/word_practice/presentation/screens/add_word_screen.dart'
    as w;
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/base_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final languagesAsync = ref.watch(languagesProvider);
    final selectedLangId = useState<int?>(
      ref.read(preferencesServiceProvider).getCourseLanguage(),
    );

    final userAsync = ref.watch(currentUserProvider);
    final isAdmin = userAsync.maybeWhen(
      data: (either) =>
          either.fold((_) => false, (user) => user?.isAdmin ?? false),
      orElse: () => false,
    );

    var langList = languagesAsync.when(
      data: (langList) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: LanguageDropdown(
          languages: langList,
          selectedId: selectedLangId,
        ),
      ),
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (err, stack) => Center(child: Text('${loc.error}: $err')),
    );

    return BaseScreen(
      isDark: isDark,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loc.home,
                        style: ThemeTextStyles.custom(
                          isDark: isDark,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          AppbarActions(isDark: isDark),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () async {
                              ref.read(signOutUseCaseProvider).call();
                              context.go(Routes.login);
                            },
                            icon: Icon(Icons.logout_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (!isAdmin)
                    userAsync.maybeWhen(
                      data: (either) => either.fold(
                        (_) => const SizedBox.shrink(),
                        (user) => user == null
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  _StatChip(
                                    icon: Icons.local_fire_department_rounded,
                                    value: '${user.streak}',
                                    label: loc.days,
                                    color: Colors.orange,
                                    isDark: isDark,
                                  ),
                                  const SizedBox(width: 12),
                                  _StatChip(
                                    icon: Icons.stars_rounded,
                                    value: '${user.xp}',
                                    label: loc.xp,
                                    color: Colors.amber,
                                    isDark: isDark,
                                  ),
                                ],
                              ),
                      ),
                      orElse: () => const SizedBox.shrink(),
                    ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                langList,
                const SizedBox(height: 24),
                if (!isAdmin)
                  MenuTile(
                    icon: Icons.layers_rounded,
                    title: loc.play_level,
                    iconColor: AppColors.successGreen,
                    onTap: () => context.go(Routes.levelGame),
                  ),
                if (!isAdmin)
                  MenuTile(
                    icon: Icons.mic_rounded,
                    title: loc.ex_pronunce,
                    iconColor: AppColors.errorRed,
                    onTap: () => context.go(Routes.pronounceGame),
                  ),
                if (!isAdmin)
                  MenuTile(
                    icon: Icons.hearing_rounded,
                    title: loc.audition,
                    iconColor: AppColors.auditionPurple,
                    onTap: () => context.go(Routes.auditionGame),
                  ),
                MenuTile(
                  icon: Icons.auto_stories_rounded,
                  title: loc.study_materials,
                  iconColor: AppColors.primaryBlue,
                  onTap: () => context.go(Routes.books),
                ),
                if (!isAdmin)
                  MenuTile(
                    icon: Icons.collections_bookmark_rounded,
                    title: loc.my_vocabulary,
                    iconColor: AppColors.auditionPurple,
                    onTap: () => context.go(Routes.vocabulary),
                  ),
                MenuTile(
                  icon: Icons.smart_toy_rounded,
                  title: loc.ai_chat,
                  iconColor: AppColors.blue,
                  onTap: () => context.push(Routes.aiChat),
                ),
                if (isAdmin) ...[
                  MenuTile(
                    icon: Icons.people_outline_rounded,
                    title: loc.user_management,
                    iconColor: AppColors.adminOrange,
                    onTap: () => context.go(Routes.adminUsers),
                  ),
                  MenuTile(
                    icon: Icons.add_circle_outline_rounded,
                    title: loc.add_study_materials,
                    iconColor: AppColors.successGreen,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const AddBookScreen(),
                      );
                    },
                  ),
                  MenuTile(
                    icon: Icons.abc_rounded,
                    title: loc.new_word,
                    iconColor: AppColors.successGreen,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const w.AddWordScreen(),
                      );
                    },
                  ),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final bool isDark;

  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 6),
          Text(
            value,
            style: ThemeTextStyles.title2Heavy(isDark: isDark, color: color),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: ThemeTextStyles.caption(isDark: isDark, color: color),
          ),
        ],
      ),
    );
  }
}
