import 'package:flutter/material.dart';

import 'package:exportacion_app/src/helpers/datosPdf.dart';

class HomePage extends StatelessWidget {
  final TextEditingController textDescripcionController =
      TextEditingController();
  final TextEditingController textCantidadController = TextEditingController();
  final TextEditingController textValorController = TextEditingController();

  final String usuario = 'Juan Perez';
  final String fechaAplicacion = '21/01/2022';

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    int totalAplicaciones = 0;
    List<List<String>> miLista = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportacion App'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Spacer(),
              const Text('Descripcion Vacuna'),
              TextField(
                controller: textDescripcionController,
              ),
              SizedBox(height: mediaQuery.height * 0.02),
              const Text('Dosis'),
              TextField(
                controller: textCantidadController,
              ),
              SizedBox(height: mediaQuery.height * 0.02),
              const Text('Cantidad'),
              TextField(
                controller: textValorController,
              ),
              SizedBox(height: mediaQuery.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        List<String> listaTemp = [];
                        listaTemp.add(textDescripcionController.text);
                        textDescripcionController.clear();
                        listaTemp.add(textCantidadController.text);
                        textCantidadController.clear();
                        listaTemp.add(textValorController.text);

                        miLista.add(listaTemp);
                        totalAplicaciones +=
                            int.tryParse(textValorController.text)!;
                        textValorController.clear();
                      },
                      child: const Text('Agregar')),
                  TextButton(
                      onPressed: () {
                        (miLista.isNotEmpty)
                            ? datosPdf(miLista, totalAplicaciones, usuario,
                                fechaAplicacion)
                            : null;
                      },
                      child: const Text('Exportar')),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
