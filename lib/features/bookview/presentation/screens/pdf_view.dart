import 'dart:async';
import 'dart:io';
import 'package:wlingo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wlingo/core/shared/shared_provider.dart';
import 'package:wlingo/theme/text_styles.dart';

class PdfViewerScreen extends HookConsumerWidget {
  const PdfViewerScreen({
    super.key,
    required this.url,
    required this.title,
    required this.bookId,
  });

  final String url;
  final String title;
  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final controller = useMemoized(() => PdfViewerController());
    final pdfFile = useState<File?>(null);
    final totalPages = useState(0);

    final currentPage = useRef<int>(1);
    final debounceTimer = useRef<Timer?>(null);

    final prefs = ref.watch(preferencesServiceProvider);

    final loadPdf = useCallback(({bool forceRefresh = false}) async {
      try {
        if (forceRefresh) {
          await DefaultCacheManager().removeFile(url);
        }
        final file = await DefaultCacheManager().getSingleFile(url);
        pdfFile.value = file;
      } catch (e) {
        talker.error('Error loading PDF: $e');
      }
    }, [url]);

    useEffect(() {
      loadPdf();
      return () => debounceTimer.value?.cancel();
    }, [url]);

    void handlePageChange(int page) {
      currentPage.value = page;
      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(const Duration(seconds: 2), () {
        prefs.saveBookPage(bookId, page);
        talker.info('Page $page saved for book $bookId');
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: ThemeTextStyles.title3SemiBold(isDark: isDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => loadPdf(forceRefresh: true),
          ),
        ],
      ),
      body: pdfFile.value == null
          ? const Center(child: CircularProgressIndicator())
          : SfPdfViewer.file(
              pdfFile.value!,
              controller: controller,
              onDocumentLoaded: (details) {
                totalPages.value = details.document.pages.count;
                final saved = prefs.getBookPage(bookId);
                if (saved > 1) {
                  Future.microtask(() => controller.jumpToPage(saved));
                  currentPage.value = saved;
                }
              },
              onPageChanged: (details) =>
                  handlePageChange(details.newPageNumber),
            ),
    );
  }
}
