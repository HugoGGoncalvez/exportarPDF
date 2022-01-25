import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:exportacion_app/src/helpers/pdf.dart';

Future<void> datosPdf(Map<String, double> aplicaciones, String usuario,
    String fechaAplicacion, int cantidadTotal, int cantidadError) async {
  String texto = 'Envío de Reporte';
  Directory tempDir = await getTemporaryDirectory();
  final file = File(
      "${tempDir.path}/$usuario ${fechaAplicacion.replaceAll('/', '-')}.pdf");
  final pdf = await generarPDF(
      aplicaciones, usuario, fechaAplicacion, cantidadTotal, cantidadError);
  await file.writeAsBytes(pdf);

  await Share.shareFiles([file.path], text: texto);
}
