import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:myshubamuhurtham/ModelClass/invoice_history_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';

class InvoiceHistoryScreen extends StatefulWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  State<InvoiceHistoryScreen> createState() => _InvoiceHistoryScreenState();
}

class _InvoiceHistoryScreenState extends State<InvoiceHistoryScreen> {
  bool isLoading = false;
  List<ProfileDatum> profieInfo = [];
  List<InvoiceDatum> invoiceHistory = [];

  @override
  void initState() {
    super.initState();
    ApiService.getinvoiceHistory().then((value) {
      if (!mounted) return;
      setState(() {
        profieInfo.addAll(value.message.profileData);
        invoiceHistory.addAll(value.message.invoiceData);
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Invoice History', true, [], MyTheme.whiteColor),
      body: isLoading
          ? invoiceHistory.isEmpty
              ? MyComponents.emptyDatatoshow(context, MyComponents.emptySearch,
                  'Invoice history is empty.', '', false, () {})
              : ListView.builder(
                  itemCount: invoiceHistory.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10.0),
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Column(children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          title: Text(
                            'Txn.id.: ${invoiceHistory[index].txnid}',
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            'Subscription Date: ${invoiceHistory[index].subsribedDate}',
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.whiteColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () {
                            askPermission(index);
                          },
                          child: FittedBox(
                            child: Text(
                              'Generate Invoice',
                              style: GoogleFonts.inter(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ]),
                    );
                  })
          : MyComponents.circularLoader(MyTheme.transparent, MyTheme.baseColor),
    );
  }

  askPermission(int index) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else {
      generateInvoiceData(index);
    }
  }

  generateInvoiceData(int index) async {
    String numToWord = NumberToWord().convert(
        'en-in', int.parse(invoiceHistory[index].amount.split('.').first));
    final pdfTopImage = pw.MemoryImage(
      (await rootBundle.load(MyComponents.pdfTopImage)).buffer.asUint8List(),
    );
    final pdfFooterImage = pw.MemoryImage(
      (await rootBundle.load(MyComponents.pdfFooterImage)).buffer.asUint8List(),
    );
    final pdfDocument = pw.Document();
    pdfDocument.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              width: PdfPageFormat.a4.width.roundToDouble(),
              height: PdfPageFormat.a4.height.roundToDouble(),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black),
              ),
              child: pw.Column(children: [
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Image(pdfTopImage),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  height: kToolbarHeight + 44.0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Row(children: [
                    pw.Container(
                      width: PdfPageFormat.a4.width.roundToDouble() - 295.0,
                      padding: const pw.EdgeInsets.only(left: 4.0, right: 4.0),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'To: ',
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.TextSpan(
                                    text: invoiceHistory[index].firstname,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Profile No.: ',
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.TextSpan(
                                    text: invoiceHistory[index].profileNo,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Email: ',
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.TextSpan(
                                    text: invoiceHistory[index].email,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Mobile No.: ',
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.TextSpan(
                                    text: invoiceHistory[index].phone,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ]),
                    ),
                    pw.Container(
                      width: PdfPageFormat.a4.width.roundToDouble() - 413.0,
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                              height: kToolbarHeight - 33,
                              alignment: pw.Alignment.center,
                              color: PdfColors.red,
                              child: pw.Text(
                                'INVOICE',
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Container(
                              width: PdfPageFormat.a4.width.roundToDouble() -
                                  413.0,
                              height: kToolbarHeight - 28,
                              alignment: pw.Alignment.centerLeft,
                              padding: const pw.EdgeInsets.only(left: 4.0),
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(color: PdfColors.black),
                                ),
                              ),
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Date: ',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: invoiceHistory[index].subsribedDate,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            pw.Container(
                              width: PdfPageFormat.a4.width.roundToDouble() -
                                  413.0,
                              height: kToolbarHeight - 28,
                              padding: const pw.EdgeInsets.only(left: 4.0),
                              alignment: pw.Alignment.centerLeft,
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Invoice No: ',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: invoiceHistory[index].id,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ]),
                    ),
                  ]),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  height: kToolbarHeight - 16.0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Row(children: [
                    pw.Container(
                      width: kToolbarHeight - 16.0,
                      height: kToolbarHeight - 16.0,
                      alignment: pw.Alignment.center,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        'Si.No',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 225.0,
                      height: kToolbarHeight - 16.0,
                      alignment: pw.Alignment.center,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        'Particulars',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 84.0,
                      height: kToolbarHeight - 16.0,
                      alignment: pw.Alignment.center,
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          children: [
                            pw.Text(
                              'Amount',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                            pw.Row(children: [
                              pw.Container(
                                width: kToolbarHeight + 44.0,
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  'Rs',
                                  style: const pw.TextStyle(fontSize: 12),
                                ),
                              ),
                              pw.Container(
                                width: kToolbarHeight - 6.0,
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  'Ps',
                                  style: const pw.TextStyle(fontSize: 12),
                                ),
                              ),
                            ]),
                          ]),
                    ),
                  ]),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  height: kToolbarHeight + 344.0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Row(children: [
                    pw.Container(
                      width: kToolbarHeight - 16.0,
                      alignment: pw.Alignment.topCenter,
                      padding: const pw.EdgeInsets.only(top: 10.0),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        '1.',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 225.0,
                      alignment: pw.Alignment.topCenter,
                      padding: const pw.EdgeInsets.only(top: 10.0),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        'Premium Package',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 84.0,
                      alignment: pw.Alignment.topCenter,
                      child: pw.Row(children: [
                        pw.Container(
                          width: kToolbarHeight + 44.0,
                          alignment: pw.Alignment.topCenter,
                          padding: const pw.EdgeInsets.only(top: 10.0),
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            invoiceHistory[index].amount.split('.').first,
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                        pw.Container(
                          width: kToolbarHeight - 6.0,
                          alignment: pw.Alignment.topCenter,
                          padding: const pw.EdgeInsets.only(top: 10.0),
                          child: pw.Text(
                            '.${invoiceHistory[index].amount.split('.').last}',
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  height: kToolbarHeight - 26.0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      top: pw.BorderSide(color: PdfColors.black),
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Row(children: [
                    pw.Container(
                      width: kToolbarHeight - 16.0,
                    ),
                    pw.Container(
                      width: kToolbarHeight + 225.0,
                      alignment: pw.Alignment.centerRight,
                      child: pw.Container(
                        width: kToolbarHeight + 54.0,
                        height: kToolbarHeight - 26.0,
                        padding: const pw.EdgeInsets.all(2.0),
                        alignment: pw.Alignment.center,
                        color: PdfColors.red,
                        child: pw.Text(
                          'GRAND TOTAL',
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 84.0,
                      alignment: pw.Alignment.center,
                      child: pw.Row(children: [
                        pw.Container(
                          width: kToolbarHeight + 44.0,
                          alignment: pw.Alignment.center,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            'Rs.${invoiceHistory[index].amount.split('.').first}',
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                        pw.Container(
                          width: kToolbarHeight - 16.0,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            '.${invoiceHistory[index].amount.split('.').last}',
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  child: pw.Row(children: [
                    pw.Container(
                      width: PdfPageFormat.a4.width.roundToDouble() / 2.4,
                      alignment: pw.Alignment.bottomLeft,
                      padding: const pw.EdgeInsets.only(
                          left: 8.0, top: 20.0, right: 8.0, bottom: 20.0),
                      child: pw.RichText(
                        text: pw.TextSpan(children: [
                          pw.TextSpan(
                            text: 'Rupees: ',
                            style: pw.TextStyle(
                                fontSize: 14, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.TextSpan(
                            text: "$numToWord Rupees Only/-",
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    pw.Container(
                      width: PdfPageFormat.a4.width.roundToDouble() / 2.5,
                      padding: const pw.EdgeInsets.only(left: 8.0, right: 8.0),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                              width:
                                  PdfPageFormat.a4.width.roundToDouble() / 2.5,
                              child: pw.Image(pdfFooterImage),
                            ),
                            pw.Container(
                              width:
                                  PdfPageFormat.a4.width.roundToDouble() / 2.5,
                              alignment: pw.Alignment.bottomCenter,
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Note: ',
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  const pw.TextSpan(
                                    text:
                                        'This is computer generated invoice no signature required.',
                                    style: pw.TextStyle(fontSize: 12),
                                  ),
                                ]),
                              ),
                            ),
                          ]),
                    ),
                  ]),
                ),
              ]),
            );
          }),
    );
    savepdfDoc(pdfDocument);
  }

  savepdfDoc(pw.Document pdfDocument) async {
    final dir = await getExternalStorageDirectory();
    String localPath = dir!.path;
    String fileName = '$localPath/SM_${DateTime.now().toString()}.pdf';
    File fileData = File(fileName);
    fileData.writeAsBytes(await pdfDocument.save(), flush: true).then((value) {
      MyComponents.navPush(
          context,
          (p0) => PdfPreviewScreen(
                pdfDocFile: value.path,
                titleHeader: 'PDF Preview',
                fileFormat: 'FileData',
              ));
    });
  }
}

class PdfPreviewScreen extends StatefulWidget {
  final String pdfDocFile, titleHeader, fileFormat;
  const PdfPreviewScreen(
      {super.key,
      required this.pdfDocFile,
      required this.titleHeader,
      required this.fileFormat});

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  PDFDocument? pdfDocument;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fileFormatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, widget.titleHeader, true, [], MyTheme.whiteColor),
      body: isLoading
          ? MyComponents.circularLoader(MyTheme.whiteColor, MyTheme.baseColor)
          : PDFViewer(document: pdfDocument!),
    );
  }

  fileFormatData() async {
    if (widget.fileFormat == 'FileData') {
      pdfDocument = await PDFDocument.fromFile(File(widget.pdfDocFile));
      debugPrint(pdfDocument!.count.toString());
      setState(() => isLoading = false);
    } else if (widget.fileFormat == 'UrlData') {
      pdfDocument = await PDFDocument.fromURL(widget.pdfDocFile);
      debugPrint(pdfDocument!.count.toString());
      setState(() => isLoading = false);
    }
  }
}
