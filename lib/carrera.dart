class Carrera {
  final int inscriptos;
  final String carrera;

  const Carrera({
    required this.carrera,
    required this.inscriptos,
  });

  factory Carrera.fromJson(Map<String, dynamic> json) {
    return Carrera(
      carrera: json['carrera'],
      inscriptos: json['inscriptos'],
    );
  }
}
