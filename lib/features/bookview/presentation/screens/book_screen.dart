import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/bookview/domain/providers/books_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';

class BooksScreen extends HookConsumerWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksNotifierProvider);

    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.study_materials,
          style: ThemeTextStyles.title3SemiBold(isDark: isDark),
        ),
        centerTitle: true,
        actions: [AppbarActions(isDark: isDark)],
      ),
      body: booksAsync.when(
        data: (books) {
          if (books.isEmpty) {
            return Center(child: Text(loc.no_materials));
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(booksNotifierProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, i) {
                final book = books[i];
                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(book.title),
                  subtitle: Text(book.author),
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
                      ref.read(booksNotifierProvider.notifier).refresh(),
                  child: Text(loc.retry),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
