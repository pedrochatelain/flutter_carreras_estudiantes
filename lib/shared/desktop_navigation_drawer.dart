import 'package:app_material_3/screen/route_carreras.dart';
import 'package:app_material_3/screen/route_estudiantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_current_screen.dart';

class DesktopNavigationDrawer extends StatefulWidget {
  const DesktopNavigationDrawer({
    super.key,
  });

  @override
  State<DesktopNavigationDrawer> createState() =>
      _DesktopNavigationDrawerState();
}

class _DesktopNavigationDrawerState extends State<DesktopNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: Provider.of<ProviderNavigationDrawer>(context, listen: true)
          .destinations,
    );
  }
}

class ProviderNavigationDrawer extends ChangeNotifier {
  var destinations = List.of([
    const SelectedDestination(
        route: RouteEstudiantes(), text: "Estudiantes", icon: Icons.person_2),
    UnselectedDestination(
        route: const RouteCarreras(),
        text: "Carreras",
        icon: Icons.view_list_outlined)
  ]);

  rebuildDestinations(Destination selected) {
    int indexOfSelected = destinations.indexOf(selected);
    for (var element in destinations) {
      destinations[destinations.indexOf(element)] =
          destinations[indexOfSelected] = UnselectedDestination(
              route: element.route, text: element.text, icon: element.icon);
    }
    destinations[indexOfSelected] = SelectedDestination(
        route: selected.route, text: selected.text, icon: selected.icon);
    notifyListeners();
  }
}

class Destination extends StatefulWidget {
  final Widget route;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final Color hoverColor;
  final Color exitHoverColor;
  final widthOfDestination = 200.0;

  const Destination({
    super.key,
    required this.route,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.icon,
    required this.iconColor,
    required this.hoverColor,
    required this.exitHoverColor,
  });

  @override
  State<Destination> createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  late Color backgroundColor;

  @override
  void initState() {
    super.initState();
    backgroundColor = widget.backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Provider.of<ProviderNavigationDrawer>(context, listen: false)
            .rebuildDestinations(widget),
        Provider.of<ProviderCurrentScreen>(context, listen: false)
            .setCurrentScreen(widget.route),
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onExit: (event) => setState(() {
          backgroundColor = widget.exitHoverColor;
        }),
        onHover: (event) => setState(() {
          backgroundColor = widget.hoverColor;
        }),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(500.0),
              bottomRight: Radius.circular(500.0),
              // topLeft: Radius.circular(40.0),
              // bottomLeft: Radius.circular(40.0)
            ),
          ),
          width: widget.widthOfDestination,
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Text(style: TextStyle(color: widget.textColor), widget.text),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(color: widget.iconColor, size: 20, widget.icon),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UnselectedDestination extends Destination {
  UnselectedDestination(
      {super.key,
      required super.route,
      required super.text,
      required super.icon})
      : super(
            backgroundColor: Colors.transparent,
            textColor: Colors.deepOrange,
            iconColor: Colors.deepOrange,
            hoverColor: Colors.deepOrange.shade50,
            exitHoverColor: Colors.transparent);
}

class SelectedDestination extends Destination {
  const SelectedDestination(
      {super.key,
      required super.route,
      required super.text,
      required super.icon})
      : super(
            backgroundColor: Colors.deepOrange,
            textColor: Colors.white,
            iconColor: Colors.white,
            hoverColor: Colors.deepOrange,
            exitHoverColor: Colors.deepOrange);
}
