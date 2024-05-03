// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_init_to_null, must_call_super

import 'package:app_material_3/estudiante_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EstudiantesPage extends StatefulWidget {
  const EstudiantesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return EstudiantesPageState();
  }
}

class EstudiantesPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DataTable(columns: [
          DataColumn(label: Text("Nombre")),
          DataColumn(label: Text("Edad"))
        ], rows: context.watch<EstudianteProvider>().estudiantes),
      ],
    );
  }
}
