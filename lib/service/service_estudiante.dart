import 'dart:convert';
import 'package:app_material_3/model/estudiante.dart';
import 'package:http/http.dart' as http;

class ServiceEstudiante {
  final String uriEstudiantes = 'https://carrest.onrender.com/api/estudiantes';

  Future<http.Response> createEstudiante(String nombre, int edad) async {
    return await http.post(
      Uri.parse(uriEstudiantes),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'nombre': nombre, 'edad': edad.toString()}),
    );
  }

  Future<List<Estudiante>> getEstudiantes() async {
    final response = await http.get(Uri.parse(uriEstudiantes));
    if (response.statusCode == 200) {
      Iterable l = json.decode(utf8.decode(response.bodyBytes));
      return List<Estudiante>.from(
          l.map((model) => Estudiante.fromJson(model)));
    } else {
      throw Exception('Failed to load estudiantes');
    }
  }
}
