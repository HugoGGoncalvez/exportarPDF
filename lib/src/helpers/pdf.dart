import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';

Future<Uint8List> generarPDF(
    List<List<String>> miLista,
    List<String> encabezado,
    int total,
    String usuario,
    String fechaAplicacion,
    String fechaHoy) async {
  final pw.Document doc = pw.Document();

  final ByteData bytes2 = await rootBundle.load('assets/logo_mvacuna.png');
  final Uint8List imgEncabezado = bytes2.buffer.asUint8List();

  doc.addPage(pw.MultiPage(
      pageFormat:
          PdfPageFormat.a4.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      header: (pw.Context context) {
        if (context.pageNumber == 1) {
          return pw.SizedBox();
        }
        return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 0.5, color: PdfColors.grey)),
            child: pw.Text('Portable Document Format',
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      build: (pw.Context context) => <pw.Widget>[
            pw.Container(
                child: pw.Image(pw.MemoryImage(imgEncabezado)),
                alignment: pw.Alignment.topLeft,
                height: 50),
            pw.Paragraph(text: ""),
            pw.Container(
                height: 10,
                child: pw.Expanded(
                    child: pw.Divider(thickness: 1.5, color: PdfColors.grey))),
            pw.Paragraph(text: ""),
            pw.Container(
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                  pw.Text('Usuario: $usuario'),
                  pw.Text('Fecha: $fechaHoy'),
                ])),
            pw.Paragraph(text: ""),
            pw.Container(
                child: pw.Text('Fecha de aplicación: $fechaAplicacion')),
            pw.Container(
                height: 10,
                child: pw.Expanded(
                    child: pw.Divider(thickness: 1.5, color: PdfColors.grey))),
            pw.Paragraph(text: ""),
            pw.Table.fromTextArray(
                headerAlignments: {0: pw.Alignment.center},
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerRight,
                },
                context: context,
                border: const pw.TableBorder(
                    left: pw.BorderSide(color: PdfColors.grey, width: 1),
                    right: pw.BorderSide(color: PdfColors.grey, width: 1),
                    top: pw.BorderSide(color: PdfColors.grey, width: 1),
                    bottom: pw.BorderSide(color: PdfColors.grey, width: 1),
                    horizontalInside:
                        pw.BorderSide(color: PdfColors.grey, width: 1),
                    verticalInside:
                        pw.BorderSide(color: PdfColors.grey, width: 1)),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headers: encabezado,
                headerCount: 1,
                cellPadding: const pw.EdgeInsets.only(left: 5, right: 5),
                data: <List<dynamic>>[
                  for (int i = 0; i < miLista.length; i++)
                    [
                      for (var e = 0; e < miLista[i].length; e++)
                        {
                          miLista[i][e],
                        }
                            .reduce((value, element) => value + element)
                            .replaceAll('{', '')
                    ],
                ]),
            pw.Paragraph(text: ""),
            pw.Paragraph(text: "Total: $total aplicaciones."),
            pw.Padding(padding: const pw.EdgeInsets.all(10)),
            pw.Paragraph(text: ""),
          ]));

  return doc.save();
}
