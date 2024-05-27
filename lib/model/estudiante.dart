class Estudiante {
  final int? libreta_universitaria;
  final String nombre;
  final String apellido;
  final int edad;

  const Estudiante(
      {required this.libreta_universitaria,
      required this.nombre,
      required this.edad,
      required this.apellido});

  Estudiante.withoutLibretaUniversitaria(
      {required this.nombre,
      required this.edad,
      required this.apellido,
      this.libreta_universitaria = null});

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
        libreta_universitaria: json['libreta_universitaria'],
        nombre: json['nombre'],
        edad: json['edad'],
        apellido: json['apellido']);
  }
}
