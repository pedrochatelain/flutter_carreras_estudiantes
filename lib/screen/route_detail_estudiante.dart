import 'dart:io';

import 'package:app_material_3/main.dart';
import 'package:app_material_3/model/estudiante.dart';
import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:app_material_3/provider/provider_inscripcion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../shared/snack_bar.dart';
import 'route_inscribir_estudiante.dart';

class RouteDetailEstudiante extends StatelessWidget {
  Estudiante estudiante;

  TextStyle estiloDetail = const TextStyle(fontSize: 30);

  RouteDetailEstudiante(this.estudiante, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const PhotoStudent(),
            NameAndLastname(estudiante: estudiante),
            const Divider(
              thickness: .2,
              indent: 30,
              endIndent: 30,
            ),
            WrapperInfoEstudiante(estudiante: estudiante),
            const Divider(
              thickness: .2,
              indent: 30,
              endIndent: 30,
            ),
            Buttons(estudiante: estudiante)
          ],
        ));
  }
}

class NameAndLastname extends StatelessWidget {
  static const double fontsize = 28;
  final Estudiante estudiante;

  const NameAndLastname({
    super.key,
    required this.estudiante,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 330,
        child: Column(
          children: [
            Text(
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(height: 1, fontSize: fontsize),
                estudiante.nombre),
            Text(
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(height: 1, fontSize: fontsize),
                estudiante.apellido),
          ],
        ),
      ),
    );
  }
}

class PhotoStudent extends StatelessWidget {
  const PhotoStudent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        radius: 70,
        backgroundImage: const AssetImage("assets/blank_profile.jfif"),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.estudiante,
  });

  final Estudiante estudiante;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonDeleteStudent(estudiante: estudiante),
          const SizedBox(
            height: 10,
          ),
          ButtonInscribirEstudiante(estudiante: estudiante),
        ],
      ),
    );
  }
}

class ButtonDeleteStudent extends StatelessWidget {
  final Estudiante estudiante;

  const ButtonDeleteStudent({
    super.key,
    required this.estudiante,
  });

  @override
  Widget build(BuildContext context) {
    http.Response deletion;
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
        ),
        onPressed: () async => {
              displayLoadingSnackbar("Borrando estudiante..."),
              deletion =
                  await Provider.of<ProviderEstudiantes>(context, listen: false)
                      .deleteStudent(estudiante),
              if (deletion.statusCode == HttpStatus.ok)
                {
                  // Provider.of<ProviderCarreras>(context).decreaseCantidadInscriptos(),
                  snackbarKey.currentState!.hideCurrentSnackBar(),
                  displaySuccessSnackbar(
                      "El estudiante ha sido borrado correctamente")
                }
            },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(color: Colors.red, size: 20, Icons.delete),
            SizedBox(
              width: 5,
            ),
            Text(style: TextStyle(color: Colors.red), "Borrar estudiante")
          ],
        ));
  }
}

class WrapperInfoEstudiante extends StatelessWidget {
  const WrapperInfoEstudiante({
    super.key,
    required this.estudiante,
  });

  final Estudiante estudiante;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  InfoEstudiante(
                      titulo: "Edad", info: estudiante.edad.toString()),
                  const InfoEstudiante(titulo: "Carreras", info: "???"),
                  const InfoEstudiante(
                      titulo: "Fecha de nacimiento", info: "05/07/1997"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => {},
                    icon: const Icon(color: Colors.deepOrange, Icons.edit)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoEstudiante extends StatelessWidget {
  final String titulo;
  final String info;

  const InfoEstudiante({super.key, required this.titulo, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(titulo),
            ],
          ),
          Row(
            children: [
              SizedBox(
                  // height: 26,
                  child: Text(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                      info))
            ],
          ),
        ],
      ),
    );
  }
}

class ButtonInscribirEstudiante extends StatelessWidget {
  const ButtonInscribirEstudiante({
    super.key,
    required this.estudiante,
  });

  final Estudiante estudiante;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.deepOrange),
        ),
        onPressed: () => showDialog(
              builder: (context) {
                return ChangeNotifierProvider(
                    create: (BuildContext context) {
                      return ProviderInscripcion();
                    },
                    child: RouteInscribirEstudiante(estudiante));
              },
              context: context,
            ),
        child: const Padding(
          padding: EdgeInsets.only(right: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(size: 20, Icons.read_more_sharp),
              SizedBox(
                width: 5,
              ),
              Text("Inscribir en carrera"),
            ],
          ),
        ));
  }
}
