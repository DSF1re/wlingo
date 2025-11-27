import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wlingo/core/repositories/book_repository.dart';
import 'package:wlingo/l10n/app_localizations.dart';
import 'package:wlingo/models/books.dart';
import 'package:wlingo/services/pdf_viewer.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final booksRepo = GetIt.I<BooksRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.study_materials),
      ),
      body: FutureBuilder<List<Book>>(
        future: booksRepo.fetchBooks(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final books = snap.data!;
          if (books.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.no_materials),
            );
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, i) {
              final book = books[i];
              return ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: Text(book.title),
                subtitle: Text(book.author),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          PdfViewerScreen(url: book.url, title: book.title),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
