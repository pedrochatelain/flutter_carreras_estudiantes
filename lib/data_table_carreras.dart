// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';

class DataTableCarreras extends StatelessWidget {
  const DataTableCarreras({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(IconButton(
                onPressed: () => {print("dw")}, icon: Icon(Icons.more_horiz))),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(IconButton(
                onPressed: () => {print("dw")}, icon: Icon(Icons.more_horiz)))
          ],
        ),
      ],
    );
  }
}
