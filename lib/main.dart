// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_init_to_null, must_call_super

import 'package:app_material_3/estudiante_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_estudiante.dart';
import 'data_table_carreras.dart';
import 'estudiantes_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => EstudianteProvider(),
    child: MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MainApp(),
    ),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool showFAB = true;
  void toggleButtonAddCarrera() => setState(() => showFAB = !showFAB);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Container(
          // width: 70,
          // height: 70,
          margin: EdgeInsets.all(5),
          child: Visibility(
            visible: showFAB,
            child: FloatingActionButton(
                child: Icon(size: 35, color: Colors.white, Icons.add),
                backgroundColor: Colors.deepOrange,
                onPressed: () async {
                  toggleButtonAddCarrera();
                  var d = await showDialog<String>(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AddEstudiante(),
                  );
                  if (d == "OK" || d == "Cancel" || d == null) {
                    toggleButtonAddCarrera();
                  }
                }),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 10,
          backgroundColor: Colors.deepOrange,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'ESTUDIANTES', icon: Icon(Icons.school_rounded)),
              Tab(text: 'CARRERAS', icon: Icon(Icons.history_edu_rounded)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EstudiantesPage(),
            CarrerasPage(),
          ],
        ),
      ),
    );
  }
}

class CarrerasPage extends StatefulWidget {
  const CarrerasPage({super.key});

  @override
  State<CarrerasPage> createState() => _CarrerasPageState();
}

class _CarrerasPageState extends State<CarrerasPage>
    with AutomaticKeepAliveClientMixin<CarrerasPage> {
  var valorInicial = 1;
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: DataTableCarreras()));
  }

  Widget getWidget() =>
      valorInicial == 1 ? CircularProgressIndicator() : DataTableCarreras();
}
