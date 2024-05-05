// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_init_to_null, must_call_super

import 'package:app_material_3/estudiante_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'service_estudiante.dart';

class AddEstudiante extends StatelessWidget {
  const AddEstudiante({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EstudianteProvider>(
      builder:
          (BuildContext context, EstudianteProvider provider, Widget? child) {
        return AlertDialog(
          actionsPadding: EdgeInsets.all(15),
          title: TituloCreateCarrera(),
          content: ContentDialog(),
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

  final EstudianteProvider provider;

  @override
  Widget build(BuildContext context) {
    Response futureEstudiante;
    var sm = ScaffoldMessenger.of(context);
    return FilledButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.deepOrange[400])),
      onPressed: () async => {
        if (!provider.hasEmptyFields())
          {
            Navigator.pop(context, 'OK'),
            futureEstudiante = await ServiceEstudiante().createEstudiante(
                provider.nombreController.text,
                int.parse(provider.edadController.text)),
            if (futureEstudiante.statusCode == 201)
              {
                provider.addEstudiante(provider.nombreController.text,
                    int.parse(provider.edadController.text)),
                displaySnackbar(sm),
                provider.clearText()
              },
          },
      },
      child: const Text('Agregar'),
    );
  }
}

void displaySnackbar(ScaffoldMessengerState sm) {
  sm.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: const Text('Estudiante agregado correctamente!'),
      action: SnackBarAction(
        label: 'Cerrar',
        onPressed: () {
          // Code to execute.
        },
      ),
    ),
  );
}

class ContentDialog extends StatelessWidget {
  const ContentDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: Provider.of<EstudianteProvider>(context, listen: false)
                .nombreController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              labelText: 'Nombre',
            ),
          ),
        ),
        TextFormField(
          controller: Provider.of<EstudianteProvider>(context, listen: false)
              .edadController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            labelText: 'Edad',
          ),
        ),
      ],
    );
  }
}

class TituloCreateCarrera extends StatelessWidget {
  const TituloCreateCarrera({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: const Text('Add student'),
    );
  }
}
