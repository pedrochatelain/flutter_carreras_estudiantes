class Carrera {
  int? inscriptos;
  String carrera;

  Carrera({
    required this.carrera,
    this.inscriptos,
  });

  Carrera.withoutInscriptos(this.carrera) {
    inscriptos = 0;
  }

  factory Carrera.fromJson(Map<String, dynamic> json) {
    return Carrera(
      carrera: json['carrera'],
      inscriptos: json['inscriptos'],
    );
  }

  @override
  String toString() {
    return carrera;
  }

  toJson() {
    return <String, String>{'nombre': carrera};
  }
}
