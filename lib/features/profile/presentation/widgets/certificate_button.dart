import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/auth/domain/entities/user.dart';
import 'package:wlingo/features/home/data/models/language.dart';
import 'package:wlingo/features/home/presentation/providers/langlist_provider.dart';
import 'package:wlingo/features/profile/application/certificate_service.dart';
import 'package:wlingo/features/word_practice/presentation/providers/lang_state/lang_state_provider.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class CertificateDownloadButton extends ConsumerWidget {
  final UserEntity user;
  final bool isDark;
  final AppLocalizations loc;

  const CertificateDownloadButton({
    super.key,
    required this.user,
    required this.isDark,
    required this.loc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = user.xp;
    if (points <= 100 || user.isAdmin) {
      return const SizedBox.shrink();
    }

    final selectedLangId = ref.watch(langStateProvider);
    final languagesAsync = ref.watch(languagesProvider);

    return languagesAsync.when(
      data: (languages) {
        final selectedLang = languages.firstWhere(
          (lang) => lang.id == selectedLangId,
          orElse: () => Language(id: 0, name: ''),
        );

        if (selectedLang.id == 0) {
          return const SizedBox.shrink();
        }

        return IconButton.filledTonal(
          onPressed: () => CertificateService.generateAndDownload(
            userId: user.id,
            userName: '${user.firstName} ${user.lastName}',
            languageId: selectedLang.id,
            languageName: selectedLang.name,
            loc: loc,
          ),
          icon: const Icon(Icons.workspace_premium_rounded, size: 20),
          tooltip: loc.downloadCertificate,
          style: IconButton.styleFrom(
            backgroundColor: Colors.blue.withValues(alpha: isDark ? 0.15 : 0.12),
            foregroundColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
