import 'package:app_material_3/model/estudiante.dart';
import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:app_material_3/service/service_estudiante.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteEstudiantes extends StatelessWidget {
  const RouteEstudiantes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold),
                "Estudiantes")),
        body: const Center(child: DataTableEstudiantes()));
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
          return DataTable2(
              isVerticalScrollBarVisible: false,
              fixedTopRows: 1,
              headingRowDecoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: .2)),
              ),
              dividerThickness: .1,
              columns: const [
                DataColumn2(label: Text("Nombre")),
                DataColumn2(label: Text("Edad"))
              ],
              rows: createRows(snapshot.data!));
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
