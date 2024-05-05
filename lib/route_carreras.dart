import 'package:app_material_3/Carrera.dart';
import 'package:app_material_3/service_carreras.dart';
import 'package:flutter/material.dart';

class RouteCarreras extends StatefulWidget {
  const RouteCarreras({super.key});

  @override
  State<RouteCarreras> createState() => _RouteCarrerasState();
}

class _RouteCarrerasState extends State<RouteCarreras>
    with AutomaticKeepAliveClientMixin<RouteCarreras> {
  var valorInicial = 1;
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(body: Center(child: DataTableCarreras()));
  }

  Widget getWidget() => valorInicial == 1
      ? const CircularProgressIndicator()
      : const DataTableCarreras();
}

class DataTableCarreras extends StatefulWidget {
  const DataTableCarreras({
    super.key,
  });

  @override
  State<DataTableCarreras> createState() => _DataTableCarrerasState();
}

class _DataTableCarrerasState extends State<DataTableCarreras> {
  late Future<List<Carrera>> carreras;

  @override
  void initState() {
    super.initState();
    carreras = ServiceCarrera().getCarreras();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Carrera>>(
      future: carreras,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var carreras = snapshot.data;
          return SingleChildScrollView(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Carrera',
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Inscriptos',
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      '',
                    ),
                  ),
                ),
              ],
              rows: List.generate(
                carreras!.length,
                (index) => _resultsAPI(
                  index,
                  carreras[index],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

DataRow _resultsAPI(index, data) {
  return DataRow(
    cells: <DataCell>[
      DataCell(
        Text(
          data.carrera,
        ),
      ),
      DataCell(
        Text(
          data.inscriptos.toString(),
        ),
      ),
      DataCell.empty
    ],
  );
}
