import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class CertificateService {
  static Future<void> generateAndDownload({
    required String userName,
    required AppLocalizations loc,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoRegular();
    final boldFont = await PdfGoogleFonts.robotoBold();

    final now = DateTime.now();
    final dateString = DateFormat.yMMMMd().format(now);

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
                  pw.SizedBox(height: 20),
                  pw.Text(
                    loc.certificateSubtitle,
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
                          pw.Text('Date: $dateString'),
                          pw.Text('Wlingo Language Platform'),
                        ],
                      ),
                      pw.Container(
                        width: 100,
                        height: 100,
                        child: pw.BarcodeWidget(
                          barcode: pw.Barcode.qrCode(),
                          data: 'https://wlingo.app/verify/certificate',
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
      name: 'certificate.pdf',
    );
  }
}
