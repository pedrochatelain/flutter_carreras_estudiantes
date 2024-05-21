import 'package:app_material_3/model/random_user.dart';
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
    Response creationEstudiante;
    var sm = ScaffoldMessenger.of(context);
    String nombre;
    String apellido;
    int edad;
    return FilledButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.deepOrange[400])),
      onPressed: () async => {
        if (!provider.hasEmptyFields())
          {
            displayLoadingSnackbar(sm, "Agregando estudiante..."),
            nombre = provider.nombreController.text,
            apellido = provider.apellidoController.text,
            edad = int.parse(provider.edadController.text),
            Navigator.pop(context, 'OK'),
            creationEstudiante = await ServiceEstudiante()
                .createEstudiante(nombre, apellido, edad),
            if (creationEstudiante.statusCode == 201)
              {
                provider.addEstudiante(nombre, apellido, edad),
                sm.clearSnackBars(),
                displaySuccessSnackbar(
                    sm, "Estudiante agregado correctamente!"),
                provider.clearText()
              }
            else
              {displayErrorSnackbar(sm, "No se pudo agregar el estudiante")}
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
        FieldDropdown(
            3,
            (RandomUser user) => user.nombre,
            "Nombre",
            Provider.of<ProviderEstudiantes>(context, listen: false)
                .nombreController),
        const SizedBox(height: 20),
        FieldDropdown(
            4,
            (RandomUser user) => user.apellido,
            "Apellido",
            Provider.of<ProviderEstudiantes>(context, listen: false)
                .apellidoController),
        const SizedBox(height: 20),
        TextFormField(
          controller: Provider.of<ProviderEstudiantes>(context, listen: false)
              .edadController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Edad',
          ),
        ),
      ],
    );
  }
}

class FieldDropdown extends StatelessWidget {
  final int _numberOfEntries;
  final Function _getField;
  final String _hintText;
  final TextEditingController _controller;
  final double _width = 230;

  const FieldDropdown(
    this._numberOfEntries,
    this._getField,
    this._hintText,
    this._controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ServiceEstudiante().getRandomUsers(_numberOfEntries),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var users = snapshot.data!;
          return DropdownMenu(
              controller: _controller,
              hintText: _hintText,
              width: _width,
              dropdownMenuEntries: List.generate(
                users.length,
                (index) => DropdownMenuEntry(
                    value: index, label: _getField(users[index])),
              ));
        }
        return DropdownMenu(
            hintText: "Cargando...",
            width: _width,
            enabled: false,
            dropdownMenuEntries: List.empty());
      },
    );
  }
}
