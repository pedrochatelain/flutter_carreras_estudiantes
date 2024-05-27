import 'package:app_material_3/model/carrera.dart';
import 'package:app_material_3/service/service_carreras.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProviderCarreras extends ChangeNotifier {
  late Future<List<Carrera>> _carreras;
  final nombreController = TextEditingController();

  void setCarreras(Future<List<Carrera>> carreras) async {
    _carreras = carreras;
  }

  Future<Response> addCarrera(String nombre) {
    Carrera c = Carrera(carrera: nombre, inscriptos: 0);
    _carreras.then((lista) => lista.add(c));
    notifyListeners();
    return ServiceCarrera().postCarrera(c);
  }

  Future<List<Carrera>> getCarreras() {
    return _carreras;
  }

  Future<void> incrementarCantidadInscriptos(Carrera c) async {
    List<Carrera> carreras = await _carreras;
    var index = carreras.indexWhere((carrera) => carrera.carrera == c.carrera);
    carreras[index].inscriptos = carreras[index].inscriptos! + 1;
    notifyListeners();
  }

  // void clearText() {
  //   nombreController.clear();
  //   edadController.clear();
  // }

  // bool hasEmptyFields() {
  //   return edadController.text == '' || nombreController.text == '';
  // }

  // Future<List<Estudiante>> getEstudiantes() {
  //   return estudiantes;
  // }
}
