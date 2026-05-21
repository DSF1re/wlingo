import 'dart:math';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class CertificateService {
  static Future<void> generateAndDownload({
    required String userId,
    required String userName,
    required int languageId,
    required String languageName,
    required AppLocalizations loc,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoRegular();
    final boldFont = await PdfGoogleFonts.robotoBold();

    final logoImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/icon.png')).buffer.asUint8List(),
    );

    final client = Supabase.instance.client;
    String certNumber;
    DateTime issueDate;

    try {
      final existing = await client
          .from('certificates')
          .select('certificate_number, created_at')
          .eq('user_id', userId)
          .eq('language_id', languageId)
          .maybeSingle();

      if (existing != null) {
        certNumber = existing['certificate_number'] as String;
        issueDate = DateTime.parse(existing['created_at'] as String);
      } else {
        final random = Random();
        certNumber = List.generate(10, (_) => random.nextInt(10)).join();
        issueDate = DateTime.now();

        await client.from('certificates').insert({
          'user_id': userId,
          'language_id': languageId,
          'certificate_number': certNumber,
        });
      }
    } catch (e) {
      // Fallback in case of database or connection issues
      final random = Random();
      certNumber = List.generate(10, (_) => random.nextInt(10)).join();
      issueDate = DateTime.now();
    }

    final dateString =
        '${issueDate.day.toString().padLeft(2, '0')}.${issueDate.month.toString().padLeft(2, '0')}.${issueDate.year}';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: font, bold: boldFont),
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Container(
              padding: const pw.EdgeInsets.all(40),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.blueAccent, width: 5),
              ),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    loc.certificateTitle,
                    style: pw.TextStyle(
                      fontSize: 40,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Image(logoImage, width: 150, height: 150),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    '${loc.certificateSubtitle} ($languageName)',
                    style: const pw.TextStyle(
                      fontSize: 20,
                      color: PdfColors.grey700,
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Text(
                    userName,
                    style: pw.TextStyle(
                      fontSize: 32,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Divider(thickness: 2, color: PdfColors.grey400),
                  pw.SizedBox(height: 20),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('${loc.dateLabel}: $dateString'),
                          pw.Text('№ $certNumber'),
                          pw.Text('Wlingo Language Platform'),
                        ],
                      ),
                      pw.Container(
                        width: 100,
                        height: 100,
                        child: pw.BarcodeWidget(
                          barcode: pw.Barcode.qrCode(),
                          data:
                              'https://wlingo.app/verify/certificate?id=$certNumber',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'certificate_${languageName.toLowerCase()}.pdf',
    );
  }
}
