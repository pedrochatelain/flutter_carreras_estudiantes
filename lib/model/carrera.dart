class Carrera {
  int? id;
  int? inscriptos;
  String carrera;

  Carrera({required this.carrera, this.inscriptos, this.id});

  Carrera.withoutInscriptos(this.carrera) {
    inscriptos = 0;
  }

  factory Carrera.fromJson(Map<String, dynamic> json) {
    return Carrera(
      carrera: json['carrera'],
      inscriptos: json['inscriptos'],
      id: json['id'],
    );
  }

  @override
  String toString() {
    return "$carrera, id: $id";
  }

  toJson() {
    return <String, String>{'nombre': carrera};
  }
}
