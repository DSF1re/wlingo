import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/core/router/routes.dart';
import 'package:wlingo/features/auth/domain/providers/auth_provider.dart';
import 'package:wlingo/features/home/domain/providers/langlist_provider.dart';
import 'package:wlingo/features/home/presentation/widgets/lang_dropdown.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/main.dart';
import 'package:wlingo/theme/text_styles.dart';
import 'package:wlingo/widgets/appbar_actions.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final languagesAsync = ref.watch(languagesProvider);
    final selectedLangId = useState<int?>(shared.getInt('lang_cource'));

    var langList = languagesAsync.when(
      data: (langList) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: LanguageDropdown(
          languages: langList,
          selectedId: selectedLangId,
        ),
      ),
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (err, stack) => Center(child: Text('${loc.error}: $err')),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.home, style: ThemeTextStyles.regular(isDark: isDark)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            ref.read(authRepositoryProvider).signOut();
            context.go(Routes.login);
          },
          icon: const Icon(Icons.logout),
        ),
        actions: [AppbarActions(isDark: isDark)],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView(children: [langList]),
        ),
      ),
    );
  }
}
