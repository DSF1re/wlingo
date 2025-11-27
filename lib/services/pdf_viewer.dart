import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/services/preferences_service.dart';

class PdfViewerScreen extends StatefulWidget {
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
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _controller = PdfViewerController();
  int _totalPages = 0;
  bool _isLoaded = false;
  bool _initialPageApplied = false; // <- важно
  late final PreferencesService prefs;

  @override
  void initState() {
    super.initState();
    prefs = GetIt.I<PreferencesService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              _controller.zoomLevel = (_controller.zoomLevel - 0.25).clamp(
                1.0,
                4.0,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              _controller.zoomLevel = (_controller.zoomLevel + 0.25).clamp(
                1.0,
                4.0,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 585),
                child: SfPdfViewer.network(
                  widget.url,
                  controller: _controller,
                  canShowScrollHead: true,
                  canShowScrollStatus: true,
                  enableDoubleTapZooming: true,
                  onDocumentLoaded: (details) async {
                    setState(() {
                      _totalPages = details.document.pages.count;
                      _isLoaded = true;
                    });

                    if (_initialPageApplied) return;

                    final savedPage = prefs.getBookPage(widget.bookId);
                    if (savedPage > 1 && savedPage <= _totalPages) {
                      // даём вьюверу дорендериться кадр и только потом прыгаем
                      await Future.delayed(const Duration(milliseconds: 50));
                      _controller.jumpToPage(savedPage);
                    }

                    _initialPageApplied = true;
                  },
                  onPageChanged: (details) {
                    // сохраняем ТОЛЬКО номер, без setState
                    prefs.saveBookPage(widget.bookId, details.newPageNumber);
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          if (_isLoaded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.black.withValues(alpha: 0.05),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      if (_controller.pageNumber > 1) {
                        _controller.previousPage();
                      }
                    },
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.page} '
                    '${_controller.pageNumber} '
                    '${AppLocalizations.of(context)!.of_total} '
                    '$_totalPages',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      if (_controller.pageNumber < _totalPages) {
                        _controller.nextPage();
                      }
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.fit_screen),
                    tooltip: AppLocalizations.of(context)!.zoom_reset,
                    onPressed: () {
                      _controller.zoomLevel = 1.0;
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
