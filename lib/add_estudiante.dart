// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_init_to_null, must_call_super

import 'package:app_material_3/estudiante_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
            FilledButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.deepOrange[400])),
              onPressed: () => {
                if (!provider.hasEmptyFields())
                  {
                    provider.addEstudiante(provider.nombreController.text,
                        int.parse(provider.edadController.text)),
                    Navigator.pop(context, 'OK'),
                    provider.clearText()
                  }
              },
              child: const Text('Agregar'),
            )
          ],
        );
      },
    );
  }
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
