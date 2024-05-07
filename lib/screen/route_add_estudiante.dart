import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          actionsPadding: const EdgeInsets.all(15),
          title: const TituloCreateCarrera(),
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
          backgroundColor: MaterialStatePropertyAll(Colors.deepOrange[400])),
      onPressed: () async => {
        if (!provider.hasEmptyFields())
          {
            displaySnackbarAgregandoEstudiante(sm),
            nombre = provider.nombreController.text,
            edad = int.parse(provider.edadController.text),
            Navigator.pop(context, 'OK'),
            futureEstudiante =
                await ServiceEstudiante().createEstudiante(nombre, edad),
            if (futureEstudiante.statusCode == 201)
              {
                provider.addEstudiante(nombre, edad),
                sm.clearSnackBars(),
                displaySnackbarEstudianteAgregado(sm),
                provider.clearText()
              },
          },
      },
      child: const Text('Agregar'),
    );
  }
}

void displaySnackbarAgregandoEstudiante(ScaffoldMessengerState sm) {
  sm.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          const Center(
              child: SizedBox(
                  height: 25, width: 25, child: CircularProgressIndicator())),
          Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text("Agregando estudiante...")),
        ],
      ),
    ),
  );
}

void displaySnackbarEstudianteAgregado(ScaffoldMessengerState sm) {
  sm.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      content: Animate(
        effects: const [SlideEffect(), FadeEffect()],
        child: Row(
          children: <Widget>[
            Icon(
              size: 30,
              Icons.check_circle_rounded,
              color: Colors.green[400],
            ),
            Container(
                margin: const EdgeInsets.only(left: 15),
                child: const Text("Estudiante agregado correctamente")),
          ],
        ),
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
            controller: Provider.of<ProviderEstudiantes>(context, listen: false)
                .nombreController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              labelText: 'Nombre',
            ),
          ),
        ),
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

class TituloCreateCarrera extends StatelessWidget {
  const TituloCreateCarrera({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text('Add student'),
    );
  }
}
