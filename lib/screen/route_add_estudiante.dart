import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:app_material_3/shared/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../service/service_estudiante.dart';

class RouteAddEstudiante extends StatelessWidget {
  const RouteAddEstudiante({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderEstudiantes>(
      builder:
          (BuildContext context, ProviderEstudiantes provider, Widget? child) {
        return AlertDialog(
          title: const Text('Add student'),
          content: const ContentDialog(),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text(
                  style: TextStyle(color: Colors.deepOrange), 'Cancelar'),
            ),
            ButtonAddEstudiante(provider: provider)
          ],
        );
      },
    );
  }
}

class ButtonAddEstudiante extends StatelessWidget {
  const ButtonAddEstudiante({
    super.key,
    required this.provider,
  });

  final ProviderEstudiantes provider;

  @override
  Widget build(BuildContext context) {
    Response futureEstudiante;
    var sm = ScaffoldMessenger.of(context);
    String nombre;
    int edad;
    return FilledButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.deepOrange[400])),
      onPressed: () async => {
        if (!provider.hasEmptyFields())
          {
            displayLoadingSnackbar(sm, "Agregando estudiante..."),
            nombre = provider.nombreController.text,
            edad = int.parse(provider.edadController.text),
            Navigator.pop(context, 'OK'),
            futureEstudiante =
                await ServiceEstudiante().createEstudiante(nombre, edad),
            if (futureEstudiante.statusCode == 201)
              {
                provider.addEstudiante(nombre, edad),
                sm.clearSnackBars(),
                displaySuccessSnackbar(
                    sm, "Estudiante agregado correctamente!"),
                provider.clearText()
              },
          },
      },
      child: const Text('Agregar'),
    );
  }
}

class ContentDialog extends StatelessWidget {
  const ContentDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: Provider.of<ProviderEstudiantes>(context, listen: false)
              .nombreController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            labelText: 'Nombre',
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: Provider.of<ProviderEstudiantes>(context, listen: false)
              .edadController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            labelText: 'Edad',
          ),
        ),
      ],
    );
  }
}
