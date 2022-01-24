import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:exportacion_app/src/helpers/pdf.dart';

Future<void> datosPdf(List<List<String>> miLista, List<String> encabezado,
    int total, String usuario, String fechaAplicacion, String fechaHoy) async {
  Directory tempDir = await getTemporaryDirectory();
  final file = File("${tempDir.path}/miPDF.pdf");
  final pdf = await generarPDF(
      miLista, encabezado, total, usuario, fechaAplicacion, fechaHoy);
  await file.writeAsBytes(pdf);

  const String texto = 'Te paso el PDF !!';

  await Share.shareFiles([file.path], text: texto);
}
