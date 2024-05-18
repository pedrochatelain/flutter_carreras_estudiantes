import 'package:app_material_3/model/estudiante.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RouteDetailEstudiante extends StatelessWidget {
  Estudiante estudiante;

  TextStyle estiloDetail = TextStyle(fontSize: 30);

  RouteDetailEstudiante(this.estudiante, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(estudiante.nombre.toString()),
          ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(234))),
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
      ),
    );
  }
}
