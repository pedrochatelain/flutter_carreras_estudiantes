import 'package:app_material_3/model/carrera.dart';
import 'package:app_material_3/provider/provider_carreras.dart';
import 'package:app_material_3/service/service_carreras.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteCarreras extends StatelessWidget {
  final valorInicial = 1;

  const RouteCarreras({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            scrolledUnderElevation: 0,
            title: const Text(
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold),
                "Carreras")),
        body: const DataTableCarreras());
  }
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
    Provider.of<ProviderCarreras>(listen: false, context).setCarreras(carreras);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Carrera>>(
      future:
          Provider.of<ProviderCarreras>(listen: true, context).getCarreras(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DataTable2(
              fixedTopRows: 1,
              headingRowDecoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: .2)),
              ),
              dividerThickness: .1,
              columns: const [
                DataColumn2(label: Text("Carrera")),
                DataColumn2(label: Text("Inscriptos"))
              ],
              rows: carrerasToDataRow(snapshot.data));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  List<DataRow> carrerasToDataRow(List<Carrera>? data) {
    List<DataRow> lista = [];
    for (var carrera in data!) {
      lista.add(DataRow(cells: [
        DataCell(Text(carrera.nombre)),
        DataCell(Text(carrera.inscriptos.toString()))
      ]));
    }
    return lista;
  }
}
