import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/bookview/presentation/providers/books_notifier.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';
import 'package:wlingo/widgets/base_screen.dart';
import 'package:wlingo/theme/app_colors.dart';
import 'package:wlingo/widgets/glass_box.dart';

class BooksScreen extends HookConsumerWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksProvider);

    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return BaseScreen(
      isDark: isDark,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    loc.study_materials,
                    style: ThemeTextStyles.title1SemiBold(isDark: isDark),
                  ),
                ),
                AppbarActions(isDark: isDark, padding: 0),
              ],
            ),
          ),
          Expanded(
            child: booksAsync.when(
              data: (books) {
                if (books.isEmpty) {
                  return Center(child: Text(loc.no_materials));
                }
                return RefreshIndicator(
                  onRefresh: () => ref.read(booksProvider.notifier).refresh(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: books.length,
                    itemBuilder: (context, i) {
                      final book = books[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Bounceable(
                          onTap: () {
                            final queryParams = {
                              'url': book.url,
                              'title': book.title,
                              'bookId': book.id.toString(),
                            };
                            context.push(
                              Uri(
                                path: Routes.pdf,
                                queryParameters: queryParams,
                              ).toString(),
                            );
                          },
                          child: GlassBox(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            opacity: isDark ? 0.08 : 0.35,
                            blur: 10,
                            borderRadius: BorderRadius.circular(20),
                            color: isDark ? Colors.white : Colors.white,
                            border: Border.all(
                              color: (isDark ? Colors.white : Colors.black)
                                  .withValues(alpha: 0.08),
                              width: 1,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.errorRed.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.picture_as_pdf_rounded,
                                    color: AppColors.errorRed,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.title,
                                        style: ThemeTextStyles.regular(
                                          fontWeight: FontWeight.w600,
                                          isDark: isDark,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        book.author,
                                        style: ThemeTextStyles.caption(
                                          isDark: isDark,
                                          color:
                                              (isDark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .withValues(alpha: 0.45),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 20,
                                  color: (isDark ? Colors.white : Colors.black)
                                      .withValues(alpha: 0.25),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${loc.error}: $err'),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        onPressed: () =>
                            ref.read(booksProvider.notifier).refresh(),
                        child: Text(loc.retry),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
