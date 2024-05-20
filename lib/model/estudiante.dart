class Estudiante {
  final String nombre;
  final String? apellido;
  final int edad;

  const Estudiante(
      {required this.nombre, required this.edad, required this.apellido});

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
        nombre: json['nombre'], edad: json['edad'], apellido: json['apellido']);
  }
}
