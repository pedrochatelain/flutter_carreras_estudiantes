import 'package:app_material_3/model/estudiante.dart';
import 'package:app_material_3/provider/provider_inscripcion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'route_inscribir_estudiante.dart';

class RouteDetailEstudiante extends StatelessWidget {
  Estudiante estudiante;

  TextStyle estiloDetail = const TextStyle(fontSize: 30);

  RouteDetailEstudiante(this.estudiante, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(estudiante.nombre.toString()),
          ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(234))),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.purple[300],
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(style: estiloDetail, estudiante.nombre),
                    Text(style: estiloDetail, estudiante.edad.toString())
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FilledButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.deepOrange)),
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
                child: const Text("Inscribir en carrera"))
          ],
        ),
      ),
    );
  }
}
