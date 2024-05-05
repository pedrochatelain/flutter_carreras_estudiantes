import 'dart:convert';
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
}
