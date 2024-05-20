class RandomUser {
  final String nombre;
  final String apellido;

  const RandomUser({
    required this.nombre,
    required this.apellido,
  });

  factory RandomUser.fromJson(Map<String, dynamic> json) {
    return RandomUser(
      nombre: json['first'],
      apellido: json['last'],
    );
  }

  @override
  String toString() {
    return "nombre: ${nombre}, apellido: ${apellido}";
  }
}
