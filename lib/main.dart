import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:app_material_3/screen/route_add_carrera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import 'provider/provider_carreras.dart';
import 'screen/route_add_estudiante.dart';
import 'screen/route_carreras.dart';
import 'screen/route_estudiantes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderEstudiantes(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderCarreras(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool showFAB = true;
  void closeDial() => setState(() => isDialOpen.value = false);
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: SpeedDial(
          overlayOpacity: .54,
          overlayColor: Colors.black54,
          openCloseDial: isDialOpen,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          icon: Icons.more_horiz,
          children: [
            SpeedDialChild(
              labelWidget: ButtonAddEstudiante(closeDial),
            ),
            SpeedDialChild(
              labelWidget: ButtonAddCarrera(closeDial),
            )
          ],
        ),
        appBar: AppBar(
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   statusBarColor: Colors.deepOrange, // Status bar
          //   systemNavigationBarColor: Colors.white, // Navigation bar
          //   systemNavigationBarIconBrightness:
          //       Brightness.dark, // Change Icon color
          // ),
          toolbarHeight: 3,
          backgroundColor: Colors.deepOrange,
          bottom: const TabBar(
            indicatorPadding: EdgeInsets.all(4),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'ESTUDIANTES', icon: Icon(Icons.school_rounded)),
              Tab(text: 'CARRERAS', icon: Icon(Icons.history_edu_rounded)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RouteEstudiantes(),
            RouteCarreras(),
          ],
        ),
      ),
    );
  }
}

class ButtonAddCarrera extends StatelessWidget {
  final void Function() closeDial;

  const ButtonAddCarrera(
    this.closeDial, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(size: 22, Icons.addchart),
            ),
            Text("Agregar carrera"),
          ],
        ),
        onPressed: () {
          closeDial();
          showDialog(
            barrierColor: Colors.black54,
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) => const RouteAddCarrera(),
          );
        });
  }
}

class ButtonAddEstudiante extends StatelessWidget {
  final void Function() closeDial;

  const ButtonAddEstudiante(
    this.closeDial, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepOrange)),
        child: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(size: 22, Icons.person_add_alt_1_rounded),
            ),
            Text("Agregar estudiante"),
          ],
        ),
        onPressed: () {
          closeDial();
          showDialog(
            barrierColor: Colors.black54,
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) => const RouteAddEstudiante(),
          );
        });
  }
}
