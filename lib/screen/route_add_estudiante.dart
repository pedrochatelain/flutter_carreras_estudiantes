import 'package:app_material_3/main.dart';
import 'package:app_material_3/model/estudiante.dart';
import 'package:app_material_3/model/random_user.dart';
import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:app_material_3/shared/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          content: ContentDialog(provider: provider),
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
    String nombre;
    String apellido;
    int edad;
    Estudiante? estudiante;
    return FilledButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.deepOrange[400])),
      onPressed: () async => {
        if (!provider.hasEmptyFields())
          {
            snackbarKey.currentState!.removeCurrentSnackBar(),
            displayLoadingSnackbar("Agregando estudiante..."),
            nombre = provider.nombreController.text,
            apellido = provider.apellidoController.text,
            edad = int.parse(provider.edadController.text),
            Navigator.pop(context, 'OK'),
            estudiante = await provider.addEstudiante(nombre, apellido, edad),
            if (estudiante != null)
              {
                snackbarKey.currentState!.removeCurrentSnackBar(),
                provider.clearText(),
                displaySnackbarEstudianteCreado(estudiante!),
              }
            else
              {displayErrorSnackbar("No se pudo agregar el estudiante")}
          },
      },
      child: const Text('Agregar'),
    );
  }
}

class ContentDialog extends StatefulWidget {
  final ProviderEstudiantes provider;

  const ContentDialog({
    super.key,
    required this.provider,
  });

  @override
  State<ContentDialog> createState() => _ContentDialogState();
}

class _ContentDialogState extends State<ContentDialog> {
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
        const EdadTextField(),
      ],
    );
  }
}

class EdadTextField extends StatefulWidget {
  const EdadTextField({
    super.key,
  });

  @override
  State<EdadTextField> createState() => _EdadTextFieldState();
}

class _EdadTextFieldState extends State<EdadTextField> {
  @override
  Widget build(BuildContext context) {
    var edadController =
        Provider.of<ProviderEstudiantes>(context, listen: false).edadController;
    bool isEdadEmpty = edadController.text.isEmpty;
    return TextFormField(
      onChanged: (value) => setState(() {
        value.isNotEmpty ? isEdadEmpty = false : isEdadEmpty = true;
      }),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value != '') {
          return (int.parse(value!) > 150) ? 'That old? 😂' : null;
        }
        return null;
      },
      controller: edadController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: !isEdadEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(() => edadController.text = ""),
              )
            : null,
        border: const OutlineInputBorder(),
        labelText: 'Edad',
      ),
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
