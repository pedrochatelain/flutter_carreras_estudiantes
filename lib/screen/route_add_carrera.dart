import 'package:app_material_3/main.dart';
import 'package:app_material_3/provider/provider_carreras.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../shared/snack_bar.dart';

class RouteAddCarrera extends StatelessWidget {
  final String textOfButton = "Agregar carrera";

  const RouteAddCarrera({super.key});

  @override
  Widget build(BuildContext context) {
    var nombreController =
        Provider.of<ProviderCarreras>(context).nombreController;
    Response response;
    return AlertDialog(
      title: const Text("Agregar carrera"),
      content: TextFormField(
          controller: nombreController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nombre',
          )),
      actions: [
        FilledButton(
            onPressed: () async => {
                  snackbarKey.currentState!.removeCurrentSnackBar(),
                  Navigator.pop(context),
                  displayLoadingSnackbar("Agregando carrera..."),
                  response = await Provider.of<ProviderCarreras>(context,
                          listen: false)
                      .addCarrera(nombreController.text),
                  if (response.statusCode == 201)
                    {
                      snackbarKey.currentState!.removeCurrentSnackBar(),
                      nombreController.text = "",
                      displaySuccessSnackbar("Carrera agregada correctamente")
                    }
                },
            child: Text(textOfButton))
      ],
    );
  }
}
