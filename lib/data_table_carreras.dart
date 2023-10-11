// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:app_material_3/Album.dart';
import 'package:app_material_3/service_carreras.dart';
import 'package:flutter/material.dart';

class DataTableCarreras extends StatefulWidget {
  const DataTableCarreras({
    super.key,
  });

  @override
  State<DataTableCarreras> createState() => _DataTableCarrerasState();
}

class _DataTableCarrerasState extends State<DataTableCarreras> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = ServiceCarrera().fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DataTable(
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
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(snapshot.data!.id.toString())),
                  DataCell(Text(snapshot.data!.title)),
                  DataCell(IconButton(
                      onPressed: () => {print("dw")},
                      icon: Icon(Icons.more_horiz))),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Janine')),
                  DataCell(Text('43')),
                  DataCell(IconButton(
                      onPressed: () => {print("dw")},
                      icon: Icon(Icons.more_horiz)))
                ],
              ),
            ],
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
