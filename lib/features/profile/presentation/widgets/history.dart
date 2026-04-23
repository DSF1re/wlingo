import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wlingo/features/profile/domain/providers/history_provider.dart';
import 'package:wlingo/features/profile/presentation/widgets/history_tile.dart';

class HistorySection extends ConsumerWidget {
  final String userId;
  final bool isDark;
  final dynamic loc;

  const HistorySection({
    super.key,
    required this.userId,
    required this.isDark,
    required this.loc,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(userHistoryProvider(userId));

    return historyAsync.when(
      loading: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) =>
          SliverToBoxAdapter(child: Center(child: Text('${loc.error}: $err'))),
      data: (history) {
        if (history.isEmpty) {
          return SliverToBoxAdapter(child: Center(child: Text(loc.history)));
        }
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final record = history[index];
                return HistoryTile(record: record, isDark: isDark);
              },
              childCount: history.length,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: true,
            ),
          ),
        );
      },
    );
  }
}
