import 'package:flutter/material.dart';
import '../model/estudiante.dart';

class ProviderEstudiantes extends ChangeNotifier {
  late Future<List<Estudiante>> estudiantes;
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final edadController = TextEditingController();

  void setEstudiantes(Future<List<Estudiante>> ests) async {
    estudiantes = ests;
  }

  void addEstudiante(String nombre, int edad) {
    Estudiante est = Estudiante(nombre: nombre, edad: edad);
    estudiantes.then((lista) => lista.add(est));
    notifyListeners();
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
