import 'package:flutter/material.dart';
import '../model/estudiante.dart';

class ProviderEstudiantes extends ChangeNotifier {
  final List<DataRow> _estudiantes = [
    DataRow(
        cells: [const DataCell(Text("Pikachu")), DataCell(Text(30.toString()))])
  ];

  final nombreController = TextEditingController();
  final edadController = TextEditingController();

  List<DataRow> get estudiantes => _estudiantes;

  void addEstudiante(String nombre, int edad) {
    Estudiante est = Estudiante(nombre: nombre, edad: edad);
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
