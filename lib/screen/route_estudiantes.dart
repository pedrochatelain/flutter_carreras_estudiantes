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
  @override
  void initState() {
    super.initState();
    Provider.of<ProviderEstudiantes>(listen: false, context)
        .setEstudiantes(ServiceEstudiante().getEstudiantes());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Estudiante>>(
      future:
          Provider.of<ProviderEstudiantes>(listen: true, context).estudiantes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var estudiantes = snapshot.data;
          return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                    height: 0,
                    thickness: .2,
                    indent: 10,
                    endIndent: 10,
                  ),
              itemCount: estudiantes!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  enabled: true,
                  onTap: () => {
                    Navigator.push(
                        context,
                        PageTransition(
                          // duration: Duration(seconds: 2),
                          child: RouteDetailEstudiante(estudiantes[index]),
                          type: PageTransitionType.rightToLeft,
                        ))
                  },
                  title: Text(estudiantes[index].nombre.toString()),
                  subtitle: Text("${estudiantes[index].edad} años"),
                  leading: Icon(color: Colors.deepOrange[300], Icons.person),
                  trailing: const Icon(size: 20, Icons.arrow_right),
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
