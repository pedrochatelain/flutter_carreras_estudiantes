import 'dart:convert';
import 'package:app_material_3/model/estudiante.dart';
import 'package:http/http.dart' as http;

class ServiceEstudiante {
  Future<http.Response> createEstudiante(String nombre, int edad) async {
    return await http.post(
      Uri.parse('https://carrest.onrender.com/api/estudiantes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'nombre': nombre, 'edad': edad.toString()}),
    );
  }

  Future<List<Estudiante>> getEstudiantes() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () async {
        final response = await http.get(Uri.parse(
            'https://carrest.onrender.com/api/estudiantes?sort=apellido'));
        if (response.statusCode == 200) {
          Iterable l = json.decode(utf8.decode(response.bodyBytes));
          return List<Estudiante>.from(
              l.map((model) => Estudiante.fromJson(model)));
        } else {
          throw Exception('Failed to load estudiantes');
        }
      },
    );
  }
}
