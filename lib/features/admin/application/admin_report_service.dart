import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class AdminReportService {
  static Future<void> generateUserStatsReport({
    required List<Map<String, dynamic>> userData,
    required AppLocalizations loc,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.robotoRegular();
    final boldFont = await PdfGoogleFonts.robotoBold();

    final chartData = userData.map((user) {
      final name = '${user['first_name']} ${user['last_name']}';
      final ratingData = user['rating'];
      int points = 0;
      if (ratingData is List && ratingData.isNotEmpty) {
        points = (ratingData[0] as Map?)?['points'] as int? ?? 0;
      } else if (ratingData is Map) {
        points = ratingData['points'] as int? ?? 0;
      }
      return _UserStat(name: name, points: points);
    }).toList();

    chartData.sort((a, b) => b.points.compareTo(a.points));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData.withFont(base: font, bold: boldFont),
        header: (pw.Context context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.Text(
            'Wlingo Admin Report',
            style: const pw.TextStyle(color: PdfColors.grey700, fontSize: 10),
          ),
        ),
        build: (pw.Context context) {
          return [
            pw.Header(level: 0, child: pw.Text(loc.rating_distribution)),
            pw.SizedBox(height: 20),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('${loc.users}: ${userData.length}'),
                pw.Text(
                  '${loc.dateLabel}: ${DateTime.now().toString().split(' ')[0]}',
                ),
              ],
            ),
            pw.SizedBox(height: 30),

            pw.Column(
              children: chartData.take(15).map((stat) {
                final maxPoints = chartData.isEmpty
                    ? 1
                    : chartData.first.points;
                final widthFactor =
                    stat.points / (maxPoints == 0 ? 1 : maxPoints);

                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(
                    children: [
                      pw.SizedBox(
                        width: 120,
                        child: pw.Text(
                          stat.name,
                          style: const pw.TextStyle(fontSize: 10),
                          overflow: pw.TextOverflow.clip,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Stack(
                          alignment: pw.Alignment.centerLeft,
                          children: [
                            pw.Container(
                              height: 12,
                              width: double.infinity,
                              color: PdfColors.grey100,
                            ),
                            pw.Container(
                              height: 12,
                              width: 300 * widthFactor,
                              color: PdfColors.blue600,
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 5),
                              child: pw.Text(
                                '${stat.points}',
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  color: widthFactor > 0.1
                                      ? PdfColors.white
                                      : PdfColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            pw.SizedBox(height: 40),

            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        loc.users,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(5),
                      child: pw.Text(
                        loc.rating,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                ...chartData.map(
                  (stat) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(stat.name),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text('${stat.points}'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'user_statistics.pdf',
    );
  }
}

class _UserStat {
  final String name;
  final int points;

  _UserStat({required this.name, required this.points});
}
