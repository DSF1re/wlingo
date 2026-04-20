import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:wlingo/l10n/app_localizations.dart';

class AdminReportService {
  static const _primary = PdfColor.fromInt(0xFF2563EB);
  static const _primaryLight = PdfColor.fromInt(0xFFEFF6FF);
  static const _dark = PdfColor.fromInt(0xFF0F172A);
  static const _textMain = PdfColor.fromInt(0xFF334155);
  static const _textMuted = PdfColor.fromInt(0xFF64748B);
  static const _bgLight = PdfColor.fromInt(0xFFF8FAFC);
  static const _border = PdfColor.fromInt(0xFFE2E8F0);
  static const _white = PdfColors.white;

  static Future<void> generateUserStatsReport({
    required List<Map<String, dynamic>> userData,
    required AppLocalizations loc,
    required String adminName,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    final pdf = pw.Document(
      title: 'Wlingo – ${loc.rating_distribution}',
      author: 'Wlingo Admin',
    );

    final font = await PdfGoogleFonts.robotoRegular();
    final boldFont = await PdfGoogleFonts.robotoBold();
    final mediumFont = await PdfGoogleFonts.robotoMedium();

    final chartData = userData.map((user) {
      final name = '${user['first_name']} ${user['last_name']}';
      final ratingData = user['rating'];
      int points = 0;
      if (ratingData is List && ratingData.isNotEmpty) {
        points = (ratingData[0] as Map?)?['points'] as int? ?? 0;
      } else if (ratingData is Map) {
        points = ratingData['points'] as int? ?? 0;
      }

      final createdAtRaw = user['created_at'];
      DateTime? createdAt;
      if (createdAtRaw is String) {
        createdAt = DateTime.tryParse(createdAtRaw);
      } else if (createdAtRaw is DateTime) {
        createdAt = createdAtRaw;
      }

      return _UserStat(name: name, points: points, createdAt: createdAt);
    }).toList();

    chartData.sort((a, b) => b.points.compareTo(a.points));

    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}';

    final theme = pw.ThemeData.withFont(
      base: font,
      bold: boldFont,
      boldItalic: mediumFont,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        theme: theme,
        margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 48),

        header: (context) => pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'WLINGO',
                      style: pw.TextStyle(
                        font: boldFont,
                        color: _primary,
                        fontSize: 24,
                        letterSpacing: 1.5,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      loc.rating_distribution.toUpperCase(),
                      style: pw.TextStyle(
                        font: mediumFont,
                        color: _textMuted,
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      loc.report.toUpperCase(),
                      style: pw.TextStyle(
                        font: boldFont,
                        color: _dark,
                        fontSize: 16,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      dateStr,
                      style: pw.TextStyle(
                        font: mediumFont,
                        color: _primary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Divider(color: _border, thickness: 1.5),
            pw.SizedBox(height: 24),
          ],
        ),

        footer: (context) => pw.Column(
          children: [
            pw.Divider(color: _border, thickness: 1),
            pw.SizedBox(height: 12),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  '${context.pageNumber} / ${context.pagesCount}',
                  style: pw.TextStyle(color: _textMuted, fontSize: 9),
                ),
              ],
            ),
          ],
        ),

        build: (context) {
          return [
            pw.Text(
              loc.users.toUpperCase(),
              style: pw.TextStyle(
                font: boldFont,
                fontSize: 14,
                color: _dark,
                letterSpacing: 1.2,
              ),
            ),
            pw.SizedBox(height: 16),

            pw.Table(
              columnWidths: {
                0: const pw.FixedColumnWidth(40),
                1: const pw.FlexColumnWidth(3),
                2: const pw.FlexColumnWidth(1),
              },
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(
                    color: _dark,
                    borderRadius: const pw.BorderRadius.vertical(
                      top: pw.Radius.circular(8),
                    ),
                  ),
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: pw.Text(
                        '#',
                        style: pw.TextStyle(
                          color: _white,
                          font: boldFont,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: pw.Text(
                        loc.users,
                        style: pw.TextStyle(
                          color: _white,
                          font: boldFont,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(12),
                      child: pw.Text(
                        loc.rating,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          color: _white,
                          font: boldFont,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                ...chartData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;
                  final isEven = index % 2 == 0;
                  return pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: isEven ? _white : _bgLight,
                      border: const pw.Border(
                        bottom: pw.BorderSide(color: _border),
                        left: pw.BorderSide(color: _border),
                        right: pw.BorderSide(color: _border),
                      ),
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        child: pw.Text(
                          '${index + 1}',
                          style: pw.TextStyle(
                            color: _textMuted,
                            font: mediumFont,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              stat.name,
                              style: pw.TextStyle(
                                color: _textMain,
                                font: boldFont,
                                fontSize: 10,
                              ),
                            ),
                            if (stat.createdAt != null)
                              pw.Text(
                                '${loc.dateLabel}: ${DateFormat('dd.MM.yyyy').format(stat.createdAt!)}',
                                style: pw.TextStyle(
                                  color: _textMuted,
                                  font: font,
                                  fontSize: 8,
                                ),
                              ),
                          ],
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        child: pw.Text(
                          '${stat.points}',
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(
                            color: _primary,
                            font: boldFont,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),

            pw.SizedBox(height: 48),

            pw.Container(
              padding: const pw.EdgeInsets.all(24),
              decoration: pw.BoxDecoration(
                color: _white,
                borderRadius: pw.BorderRadius.circular(16),
                border: pw.Border.all(color: _border, width: 2),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        loc.compiled_by.toUpperCase(),
                        style: pw.TextStyle(
                          color: _textMuted,
                          font: boldFont,
                          fontSize: 10,
                          letterSpacing: 1.2,
                        ),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 36,
                            height: 36,
                            alignment: pw.Alignment.center,
                            decoration: pw.BoxDecoration(
                              color: _primaryLight,
                              borderRadius: pw.BorderRadius.circular(10),
                            ),
                            child: pw.Text(
                              adminName.isNotEmpty
                                  ? adminName[0].toUpperCase()
                                  : 'A',
                              style: pw.TextStyle(
                                font: boldFont,
                                fontSize: 16,
                                color: _primary,
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 12),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                adminName,
                                style: pw.TextStyle(
                                  font: boldFont,
                                  fontSize: 14,
                                  color: _dark,
                                ),
                              ),
                              pw.Text(
                                '${loc.admin} • $dateStr',
                                style: pw.TextStyle(
                                  font: mediumFont,
                                  fontSize: 10,
                                  color: _textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Container(
                        width: 160,
                        height: 40,
                        alignment: pw.Alignment.bottomRight,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(
                            bottom: pw.BorderSide(color: _textMain, width: 1),
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        loc.signature,
                        style: pw.TextStyle(
                          font: mediumFont,
                          fontSize: 10,
                          color: _textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'wlingo_user_statistics_$dateStr.pdf',
    );
  }
}

class _UserStat {
  final String name;
  final int points;
  final DateTime? createdAt;

  _UserStat({required this.name, required this.points, this.createdAt});
}
