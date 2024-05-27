import 'package:flutter/material.dart';

import '../model/carrera.dart';

class ProviderInscripcion extends ChangeNotifier {
  Carrera? carreraSeleccionada;

  ProviderInscripcion();

  updateCarrera(Carrera carrera) {
    carreraSeleccionada = carrera;
    notifyListeners();
  }
}
