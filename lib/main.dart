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
          navigationBarTheme: const NavigationBarThemeData(
              iconTheme:
                  MaterialStatePropertyAll(IconThemeData(color: Colors.white)),
              labelTextStyle:
                  MaterialStatePropertyAll(TextStyle(color: Colors.white))),
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
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [const RouteEstudiantes(), const RouteCarreras()];
  }

  int currentPageIndex = 0;
  void closeDial() => setState(() => isDialOpen.value = false);
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.deepOrange,
          onDestinationSelected: (int index) {
            setState(() => currentPageIndex = index);
          },
          indicatorColor: Colors.deepOrange[800],
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.person_2),
              icon: Icon(Icons.person_2_outlined),
              label: 'Estudiantes',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.view_list),
              icon: Icon(Icons.view_list_outlined),
              label: 'Carreras',
            )
          ]),
      body: IndexedStack(index: currentPageIndex, children: _children),
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
