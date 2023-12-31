import 'dart:convert';

import 'package:app_material_3/Carrera.dart';
import 'package:http/http.dart' as http;

class ServiceCarrera {
  Future<List<Carrera>> getCarreras() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () async {
        final response = await http.get(Uri.parse(
            'https://carrest.onrender.com/api/carreras?sort=cantidad-inscriptos'));
        if (response.statusCode == 200) {
          Iterable l = json.decode(utf8.decode(response.bodyBytes));
          List<Carrera> carreras =
              List<Carrera>.from(l.map((model) => Carrera.fromJson(model)));

          return carreras;
        } else {
          throw Exception('Failed to load album');
        }
      },
    );
  }
}
