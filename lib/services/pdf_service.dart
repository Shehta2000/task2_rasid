import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generatePortfolioPdf() async {
  final pdf = pw.Document();

  final arabicFont = await PdfGoogleFonts.amiriRegular();
  final englishFont = await PdfGoogleFonts.robotoRegular();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => [
        _buildPersonalInfo(englishFont),
        _buildArabicSection(arabicFont),
        _buildEnglishSection(englishFont),
        _buildAdditionalSections(englishFont),
      ],
      footer: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
          child: pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: pw.TextStyle(color: PdfColors.grey, font: englishFont),
          ),
        );
      },
    ),
  );

  try {
    // حفظ ملف PDF
    final output = await getTemporaryDirectory();
    if (output != null) {
      final filePath = "${output.path}/portfolio.pdf";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // فتح ملف PDF
      await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
    } else {
      print("Error: Temporary directory is null");
    }
  } catch (e) {
    print("Error saving PDF: $e");
  }
}

pw.Widget _buildPersonalInfo(pw.Font font) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text('Mohamed Shehta Hussien ', style: pw.TextStyle(fontSize: 24, font: font)),
      pw.Text('Contact: +201013215625', style: pw.TextStyle(fontSize: 24, font: font)),
      // أضف المزيد من المعلومات الشخصية هنا
    ],
  );
}

pw.Widget _buildArabicSection(pw.Font font) {
  return pw.Directionality(
    textDirection: pw.TextDirection.rtl,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('معلومات شخصية', style: pw.TextStyle(fontSize: 24, font: font)),
        pw.Text('الاسم: محمد شحته حسين ', style: pw.TextStyle(fontSize: 24, font: font)),
        // أضف المزيد من المحتوى العربي هنا
      ],
    ),
  );
}

pw.Widget _buildEnglishSection(pw.Font font) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text('Personal Information', style: pw.TextStyle(fontSize: 24, font: font)),
      pw.Text('Name : Mohamed Shehta Hussien', style: pw.TextStyle(fontSize: 24, font: font)),
      // أضف المزيد من المحتوى الإنجليزي هنا
    ],
  );
}

pw.Widget _buildAdditionalSections(pw.Font font) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text('Work Experience : Information Technology Institute (ITI) ' , style: pw.TextStyle(fontSize: 24, font: font)),
      // أضف تفاصيل الخبرة العملية هنا
      pw.Text('Projects or Achievements : (chatBubble) ,  (News) , (Toku Learning  ),(NoteBox) ', style: pw.TextStyle(fontSize: 24, font: font)),
      // أضف المشاريع أو الإنجازات هنا
      pw.Text('Skills :  dart & Oop , Local Database (Hive) , Firebase , Bloc&Cubit ', style: pw.TextStyle(fontSize: 24, font: font)),
      // أضف المهارات هنا
    ],
  );
}