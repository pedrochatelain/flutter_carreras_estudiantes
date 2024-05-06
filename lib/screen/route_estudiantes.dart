import 'package:app_material_3/model/estudiante.dart';
import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:app_material_3/service/service_estudiante.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteEstudiantes extends StatefulWidget {
  const RouteEstudiantes({super.key});

  @override
  RouteEstudiantesState createState() => RouteEstudiantesState();
}

class RouteEstudiantesState extends State<RouteEstudiantes>
    with AutomaticKeepAliveClientMixin<RouteEstudiantes> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProviderEstudiantes>(listen: false, context)
        .setEstudiantes(ServiceEstudiante().getEstudiantes());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Estudiante>>(
      future:
          Provider.of<ProviderEstudiantes>(listen: true, context).estudiantes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
              child: DataTable(columns: const [
            DataColumn(label: Text("Nombre")),
            DataColumn(label: Text("Edad"))
          ], rows: createRows(snapshot.data!)));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  List<DataRow> createRows(List<Estudiante> data) {
    List<DataRow> rows = [];

    for (Estudiante est in data) {
      rows.add(DataRow(cells: [
        DataCell(Text(est.nombre)),
        DataCell(Text(est.edad.toString()))
      ]));
    }

    return rows;
  }
}
