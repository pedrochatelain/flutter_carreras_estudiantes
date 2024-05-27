import 'dart:convert';

import 'package:app_material_3/service/service_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/estudiante.dart';

class ProviderEstudiantes extends ChangeNotifier {
  late Future<List<Estudiante>> estudiantes;
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final edadController = TextEditingController();

  void setEstudiantes(Future<List<Estudiante>> ests) async {
    estudiantes = ests;
  }

  Future<http.Response> addEstudiante(
      String nombre, String apellido, int edad) async {
    http.Response creation =
        await ServiceEstudiante().createEstudiante(nombre, apellido, edad);
    var data = jsonDecode(creation.body);
    Estudiante estudianteCreated = Estudiante.fromJson(data['entity']);
    estudiantes.then((lista) => lista.add(estudianteCreated));
    notifyListeners();
    return creation;
  }

  void clearText() {
    nombreController.clear();
    apellidoController.clear();
    edadController.clear();
  }

  bool hasEmptyFields() {
    return edadController.text == '' ||
        nombreController.text == '' ||
        apellidoController.text == '';
  }
}
