import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../screen/route_add_carrera.dart';
import '../screen/route_add_estudiante.dart';

class MainSpeedDial extends StatefulWidget {
  const MainSpeedDial({
    super.key,
  });

  @override
  State<MainSpeedDial> createState() => _MainSpeedDialState();
}

class _MainSpeedDialState extends State<MainSpeedDial> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      onClose: () => closeSpeedDial(),
      onPress: () => setState(() => isDialOpen.value = true),
      overlayOpacity: 0,
      overlayColor: Colors.black54,
      openCloseDial: isDialOpen,
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
      icon: isDialOpen.value == false ? Icons.add : Icons.close,
      children: [
        SpeedDialChild(
          labelWidget: ButtonAddEstudiante(closeSpeedDial: closeSpeedDial),
        ),
        SpeedDialChild(
          labelWidget: ButtonAddCarrera(closeSpeedDial: closeSpeedDial),
        )
      ],
    );
  }

  closeSpeedDial() => {setState(() => isDialOpen.value = false)};
}

class ButtonAddCarrera extends StatelessWidget {
  final Function closeSpeedDial;

  const ButtonAddCarrera({super.key, required this.closeSpeedDial});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.deepOrange)),
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
          closeSpeedDial();
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
  final Function closeSpeedDial;

  const ButtonAddEstudiante({super.key, required this.closeSpeedDial});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.deepOrange)),
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
          closeSpeedDial();
          showDialog(
            barrierColor: Colors.black54,
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) => const RouteAddEstudiante(),
          );
        });
  }
}
