import 'dart:io';

import 'package:app_material_3/main.dart';
import 'package:app_material_3/service/service_login.dart';
import 'package:app_material_3/shared/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProviderLogin extends ChangeNotifier {
  final ServiceLogin serviceLogin = ServiceLogin();
  bool isLogging = false;

  void loginAsAdmin() async {
    isLogging = true;
    notifyListeners();
    Response response = await serviceLogin.login("admin", "admin");
    // if response has a token
    if (response.body.contains("token")) {
      Navigator.pushReplacement(
          navKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const MainApp(),
          ));
    }
    // if response doesn't have a body
    if (response.body == '') {
      displayErrorSnackbar("Error al iniciar sesión");
      isLogging = false;
      notifyListeners();
    }
    // if timeout
    if (response.statusCode == HttpStatus.requestTimeout) {
      displayErrorSnackbar(response.body);
      isLogging = false;
      notifyListeners();
    }
  }
}
