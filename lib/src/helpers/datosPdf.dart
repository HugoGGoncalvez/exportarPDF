import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:exportacion_app/src/helpers/pdf.dart';

Future<void> datosPdf(Map<String, double> aplicaciones, String usuario,
    String fechaAplicacion, int cantidadTotal, int cantidadError) async {
  Directory tempDir = await getTemporaryDirectory();
  final file = File("${tempDir.path}/miPDF.pdf");
  final pdf = await generarPDF(
      aplicaciones, usuario, fechaAplicacion, cantidadTotal, cantidadError);
  await file.writeAsBytes(pdf);

  const String texto = 'Te paso el PDF !!';

  await Share.shareFiles([file.path], text: texto);
}
