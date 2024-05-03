import 'package:flutter/material.dart';

class Estudiante {
  String nombre;
  int edad;

  Estudiante(this.nombre, this.edad);

  @override
  String toString() {
    return "$nombre, $edad";
  }
}

class EstudianteProvider extends ChangeNotifier {
  final List<DataRow> _estudiantes = [
    DataRow(
        cells: [const DataCell(Text("Pikachu")), DataCell(Text(30.toString()))])
  ];

  final nombreController = TextEditingController();
  final edadController = TextEditingController();

  List<DataRow> get estudiantes => _estudiantes;

  void addEstudiante(String nombre, int edad) {
    Estudiante est = Estudiante(nombre, edad);
    _estudiantes.add(DataRow(cells: [
      DataCell(Text(est.nombre)),
      DataCell(Text(est.edad.toString()))
    ]));
    notifyListeners();
  }

  void clearText() {
    nombreController.clear();
    edadController.clear();
  }

  bool hasEmptyFields() {
    return edadController.text == '' || nombreController.text == '';
  }
}
