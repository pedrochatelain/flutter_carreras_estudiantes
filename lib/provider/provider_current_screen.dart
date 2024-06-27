import 'package:app_material_3/screen/route_estudiantes.dart';
import 'package:flutter/material.dart';

class ProviderCurrentScreen extends ChangeNotifier {
  Widget currentScreen = const RouteEstudiantes();
  int currentIndex = 0;

  setCurrentScreen(Widget newScreen) {
    currentScreen = newScreen;
    notifyListeners();
  }

  int setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
    return currentIndex;
  }
}
