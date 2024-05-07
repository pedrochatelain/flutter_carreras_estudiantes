// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_init_to_null, must_call_super

import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import 'screen/route_add_estudiante.dart';
import 'screen/route_carreras.dart';
import 'screen/route_estudiantes.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ProviderEstudiantes(),
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
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: SpeedDial(
          openCloseDial: isDialOpen,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          icon: Icons.more_horiz,
          children: [
            SpeedDialChild(
              labelWidget: FilledButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange)),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text("Agregar estudiante"),
                    ],
                  ),
                  onPressed: () async {
                    setState(() => isDialOpen.value = false);
                    toggleButtonAddCarrera();
                    var d = await showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => RouteAddEstudiante(),
                    );
                    if (d == "OK" || d == "Cancel" || d == null) {
                      toggleButtonAddCarrera();
                    }
                  }),
            )
          ],
        ),
        // Container(
        //   margin: EdgeInsets.all(5),
        //   child: Visibility(
        //     visible: showFAB,
        // child: FloatingActionButton(
        //     child: Icon(
        //         size: 35, color: Colors.white, Icons.more_horiz_rounded),
        //     backgroundColor: Colors.deepOrange,
        //     onPressed: () async {
        //       toggleButtonAddCarrera();
        //       var d = await showDialog<String>(
        //         barrierDismissible: false,
        //         context: context,
        //         builder: (BuildContext context) => RouteAddEstudiante(),
        //       );
        //       if (d == "OK" || d == "Cancel" || d == null) {
        //         toggleButtonAddCarrera();
        //       }
        //     }),
        //   ),
        // ),
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
            RouteEstudiantes(),
            RouteCarreras(),
          ],
        ),
      ),
    );
  }
}
