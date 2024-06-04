import 'dart:convert';
import 'dart:io';

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

  Future<Estudiante?> addEstudiante(
      String nombre, String apellido, int edad) async {
    http.Response creation =
        await ServiceEstudiante().createEstudiante(nombre, apellido, edad);
    if (creation.statusCode == HttpStatus.created) {
      var data = json.decode(utf8.decode(creation.bodyBytes));
      Estudiante estudianteCreated = Estudiante.fromJson(data['entity']);
      estudiantes.then((lista) => lista.add(estudianteCreated));
      notifyListeners();
      return estudianteCreated;
    }
    return null;
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

  Future<http.Response> deleteStudent(Estudiante estudiante) async {
    http.Response deletion =
        await ServiceEstudiante().deleteStudent(estudiante);
    if (deletion.statusCode == HttpStatus.ok) {
      estudiantes.then((list) => list.remove(estudiante));
      notifyListeners();
    }
    return deletion;
  }
}
