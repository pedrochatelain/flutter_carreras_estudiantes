import 'package:app_material_3/screen/route_estudiantes.dart';
import 'package:flutter/material.dart';

class ProviderCurrentScreen extends ChangeNotifier {
  Widget currentScreen = RouteEstudiantes();

  setCurrentScreen(Widget newScreen) {
    currentScreen = newScreen;
    notifyListeners();
  }
}
