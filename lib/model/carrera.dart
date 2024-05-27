class Carrera {
  int? id;
  int? inscriptos;
  String nombre;

  Carrera({required this.nombre, this.inscriptos, this.id});

  Carrera.withoutInscriptos(this.nombre) {
    inscriptos = 0;
  }

  factory Carrera.fromJson(Map<String, dynamic> json) {
    return Carrera(
      nombre: json['carrera'],
      inscriptos: json['inscriptos'],
      id: json['id'],
    );
  }

  @override
  String toString() {
    return "$nombre, id: $id";
  }

  toJson() {
    return <String, String>{'nombre': nombre};
  }
}
