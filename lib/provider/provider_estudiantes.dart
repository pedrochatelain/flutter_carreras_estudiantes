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
  final fechaNacimientoController = TextEditingController();

  void setEstudiantes(Future<List<Estudiante>> ests) async {
    estudiantes = ests;
  }

  void setFechaNacimiento(String fechaNacimiento) {
    fechaNacimientoController.value = TextEditingValue(text: fechaNacimiento);
    notifyListeners();
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

  void addToList(Estudiante est) {
    estudiantes.then((lista) => lista.add(Estudiante(
        libreta_universitaria: est.libreta_universitaria,
        nombre: est.nombre,
        edad: est.edad,
        apellido: est.apellido)));
    notifyListeners();
  }

  void clearText() {
    nombreController.clear();
    apellidoController.clear();
    edadController.clear();
    fechaNacimientoController.clear();
  }

  bool hasEmptyFields() {
    return edadController.text == '' ||
        nombreController.text == '' ||
        apellidoController.text == '';
  }

  Future<http.Response> deleteStudent(Estudiante estudiante) async {
    return ServiceEstudiante().deleteStudent(estudiante);
  }

  void removeStudentFromList(Estudiante estudiante) {
    estudiantes.then((list) => list.remove(estudiante));
    notifyListeners();
  }

  setEdad(d) {
    edadController.value = TextEditingValue(text: d.toString());
    notifyListeners();
  }
}
