import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key, required this.url, required this.title});

  final String url; // прямой URL на файл в Supabase Storage
  final String title;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? _localPath;
  bool _isLoading = true;
  int _pages = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _downloadPdf();
  }

  Future<void> _downloadPdf() async {
    try {
      final res = await http.get(Uri.parse(widget.url));
      final bytes = res.bodyBytes;

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temp_book.pdf');
      await file.writeAsBytes(bytes, flush: true);

      if (!mounted) return;
      setState(() {
        _localPath = file.path;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Не удалось загрузить PDF')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _isLoading || _localPath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: _localPath!,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: true,
              pageFling: true,
              onRender: (pages) {
                setState(() {
                  _pages = pages ?? 0;
                });
              },
              onViewCreated: (controller) {},
              onPageChanged: (page, total) {
                setState(() {
                  _currentPage = page ?? 0;
                });
              },
            ),
      bottomNavigationBar: _pages > 0
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Страница ${_currentPage + 1} из $_pages',
                textAlign: TextAlign.center,
              ),
            )
          : null,
    );
  }
}
