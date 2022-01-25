import 'package:flutter/material.dart';

import 'package:exportacion_app/src/helpers/datosPdf.dart';

class HomePage extends StatelessWidget {
  final TextEditingController textDescripcionController =
      TextEditingController();
  final TextEditingController textCantidadController = TextEditingController();
  final TextEditingController textValorController = TextEditingController();

  final String usuario = 'Juan Perez';
  final String fechaAplicacion = '21/01/2022';
  final aplicaciones = <String, double>{};
  int cantidadTotal = 1000;
  int cantidadError = 1250;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    aplicaciones.addAll({'Pfizer': 1000.0});
    aplicaciones.addAll({'Sputnik': 1250.0});
    aplicaciones.addAll({'Moderna': 1250.0});
    aplicaciones.addAll({'astraZeneca': 1250.0});
    aplicaciones.addAll({'Sinopharm': 1250.0});

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportacion App'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              datosPdf(aplicaciones, usuario, fechaAplicacion, cantidadTotal,
                  cantidadError);
            },
            child: const Text('Exportar')),
      ),
    );
  }
}
