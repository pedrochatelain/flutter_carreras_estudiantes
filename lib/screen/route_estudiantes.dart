// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_init_to_null, must_call_super

import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteEstudiantes extends StatefulWidget {
  const RouteEstudiantes({super.key});

  @override
  State<StatefulWidget> createState() {
    return RouteEstudiantesState();
  }
}

class RouteEstudiantesState extends State {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DataTable(columns: [
          DataColumn(label: Text("Nombre")),
          DataColumn(label: Text("Edad"))
        ], rows: context.watch<ProviderEstudiantes>().estudiantes),
      ],
    );
  }
}
