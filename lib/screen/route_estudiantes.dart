import 'package:app_material_3/model/estudiante.dart';
import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:app_material_3/service/service_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'route_detail_estudiante.dart';

class RouteEstudiantes extends StatelessWidget {
  const RouteEstudiantes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            scrolledUnderElevation: 0,
            title: const Text(
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold),
                "Estudiantes")),
        body: const DataTableEstudiantes());
  }
}

class DataTableEstudiantes extends StatefulWidget {
  const DataTableEstudiantes({super.key});

  @override
  State<StatefulWidget> createState() => DataTableEstudiantesState();
}

class DataTableEstudiantesState extends State<DataTableEstudiantes> {
  Image? imageOfEmptyClassroom;
  @override
  void initState() {
    super.initState();
    imageOfEmptyClassroom = Image.asset("assets/empty_classroom.jpg");
    Provider.of<ProviderEstudiantes>(listen: false, context)
        .setEstudiantes(ServiceEstudiante().getEstudiantes());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(imageOfEmptyClassroom!.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Estudiante>>(
      future:
          Provider.of<ProviderEstudiantes>(listen: true, context).estudiantes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var estudiantes = snapshot.data;
          return estudiantes!.isEmpty
              ? ScreenEmptyListOfStudents(
                  imageOfEmptyClassroom: imageOfEmptyClassroom)
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        height: 0,
                        thickness: .2,
                        indent: 10,
                        endIndent: 10,
                      ),
                  itemCount: estudiantes.length,
                  itemBuilder: (context, index) {
                    return ListTileEstudiante(estudiante: estudiantes[index]);
                  });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class ScreenEmptyListOfStudents extends StatelessWidget {
  const ScreenEmptyListOfStudents({
    super.key,
    required this.imageOfEmptyClassroom,
  });

  final Image? imageOfEmptyClassroom;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: Opacity(
              opacity: .6,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      child: imageOfEmptyClassroom)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                "It seems the clasroom is empty..."),
          ),
        ],
      ),
    );
  }
}

class ListTileEstudiante extends StatelessWidget {
  final Estudiante estudiante;

  const ListTileEstudiante({
    super.key,
    required this.estudiante,
  });

  @override
  Widget build(BuildContext context) {
    var nombre = estudiante.nombre.toString();
    var apellido = estudiante.apellido.toString();
    return ListTile(
      enableFeedback: false,
      contentPadding: const EdgeInsets.all(12),
      // enabled: false,
      onTap: () => {
        Navigator.push(
            context,
            PageTransition(
              child: RouteDetailEstudiante(estudiante),
              type: PageTransitionType.rightToLeft,
            ))
      },
      title: Text("$nombre $apellido"),
      subtitle: Text("${estudiante.edad} años"),
      leading: Icon(color: Colors.deepOrange[300], Icons.person),
      trailing: const Icon(size: 20, Icons.arrow_right),
    );
  }
}
