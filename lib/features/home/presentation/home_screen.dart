import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/core/shared/shared_provider.dart';
import 'package:wlingo/features/auth/presentation/providers/usecase_providers.dart';
import 'package:wlingo/features/auth/presentation/providers/current_user_provider.dart';
import 'package:wlingo/features/bookview/presentation/add_book_screen.dart';
import 'package:wlingo/features/home/presentation/providers/langlist_provider.dart';
import 'package:wlingo/features/home/presentation/widgets/lang_dropdown.dart';
import 'package:wlingo/features/home/presentation/widgets/menu_tile.dart';
import 'package:wlingo/features/word_practice/presentation/add_word_screen.dart'
    as w;
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/theme/spacing.dart';
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                          Spacing.wSm,
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
                  Spacing.hLg,
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                langList,
                Spacing.hXxl,
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
                  iconColor: AppColors.primaryBlue,
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
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}
