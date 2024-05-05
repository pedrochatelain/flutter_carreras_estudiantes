class Estudiante {
  final String nombre;
  final int edad;

  const Estudiante({
    required this.nombre,
    required this.edad,
  });

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      nombre: json['nombre'],
      edad: json['edad'],
    );
  }
}
