import 'dart:io';

import 'package:app_material_3/main.dart';
import 'package:app_material_3/model/estudiante.dart';
import 'package:app_material_3/provider/provider_carreras.dart';
import 'package:app_material_3/provider/provider_inscripcion.dart';
import 'package:app_material_3/service/service_estudiante.dart';
import 'package:app_material_3/shared/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/carrera.dart';

class RouteInscribirEstudiante extends StatefulWidget {
  final Estudiante estudiante;

  const RouteInscribirEstudiante(
    this.estudiante, {
    super.key,
  });

  @override
  State<RouteInscribirEstudiante> createState() =>
      _RouteInscribirEstudianteState();
}

class _RouteInscribirEstudianteState extends State<RouteInscribirEstudiante> {
  @override
  Widget build(BuildContext context) {
    Carrera? carrera = Provider.of<ProviderInscripcion>(context, listen: true)
        .carreraSeleccionada;
    Estudiante estudiante = widget.estudiante;
    http.Response response;
    return AlertDialog(
      title: Text("Inscribir a ${widget.estudiante.nombre} en ..."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            future: Provider.of<ProviderCarreras>(context).getCarreras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DropdownCarrera(snapshot);
              }
              return DropdownMenu(
                  width: 300,
                  hintText: "Cargando...",
                  enabled: false,
                  dropdownMenuEntries: List.empty());
            },
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => {Navigator.of(context).pop()},
            child: const Text(
                style: TextStyle(color: Colors.deepOrange), "Cancelar")),
        FilledButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.deepOrange)),
            child: const Text("Inscribir"),
            onPressed: () async => {
                  snackbarKey.currentState!.removeCurrentSnackBar(),
                  Navigator.pop(context),
                  displayLoading(estudiante, carrera!),
                  response = await inscribirEstudiante(estudiante, carrera),
                  snackbarKey.currentState!.removeCurrentSnackBar(),
                  if (response.statusCode == HttpStatus.created)
                    {
                      displaySuccess(estudiante, carrera),
                      Provider.of<ProviderCarreras>(snackbarKey.currentContext!,
                              listen: false)
                          .incrementarCantidadInscriptos(carrera),
                    }
                  else if (response.statusCode == HttpStatus.conflict)
                    {displayError(estudiante, carrera)}
                }),
      ],
    );
  }
}

Future<http.Response> inscribirEstudiante(
    Estudiante estudiante, Carrera carrera) {
  return ServiceEstudiante().inscribirEstudianteEnCarrera(
      estudiante.libreta_universitaria!, carrera.id!);
}

displaySuccess(Estudiante estudiante, Carrera carrera) {
  displaySuccessSnackbar(
      "Se inscribió a ${estudiante.nombre} en ${carrera.nombre}");
}

displayError(Estudiante estudiante, Carrera carrera) {
  displayErrorSnackbar(
      "${estudiante.nombre} ya fue inscripto/a en ${carrera.nombre}");
}

displayLoading(Estudiante estudiante, Carrera carrera) {
  displayLoadingSnackbar(
      "Inscribiendo a ${estudiante.nombre} en ${carrera.nombre}");
}

class DropdownCarrera extends StatefulWidget {
  final AsyncSnapshot snapshot;

  const DropdownCarrera(
    this.snapshot, {
    super.key,
  });

  @override
  State<DropdownCarrera> createState() => _DropdownCarreraState(snapshot);
}

class _DropdownCarreraState extends State<DropdownCarrera> {
  AsyncSnapshot snapshot;

  _DropdownCarreraState(this.snapshot);

  @override
  Widget build(BuildContext context) {
    var selectedCarrera =
        Provider.of<ProviderInscripcion>(context).carreraSeleccionada;
    var items = getCarreras(snapshot.data);
    return Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade400)),
      child: DropdownButton<Carrera>(
        // hint: const Text("Elegir carrera"),
        menuMaxHeight: 200,
        padding: const EdgeInsets.all(8),
        isExpanded: true,
        style: const TextStyle(color: Colors.black, fontSize: 17),
        // hint: items[0],
        value: selectedCarrera,
        items: items,
        // items: getCarreras(carreras),
        onChanged: (val) {
          Provider.of<ProviderInscripcion>(context, listen: false)
              .updateCarrera(val!);
        },
      ),
    );
  }

  List<DropdownMenuItem<Carrera>> getCarreras(List<Carrera> carreras) {
    List<DropdownMenuItem<Carrera>> result = [];
    for (var carrera in carreras) {
      result.add(DropdownMenuItem(value: carrera, child: Text(carrera.nombre)));
    }
    return result;
  }
}
