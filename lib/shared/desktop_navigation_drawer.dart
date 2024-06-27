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
  List<Destination> destinations = [];
  int index = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // listen to index changes
    index =
        Provider.of<ProviderCurrentScreen>(context, listen: true).currentIndex;
    // listen to destination changes
    destinations = Provider.of<ProviderNavigationDrawer>(context, listen: true)
        .destinations;
    // rebuild destinations when changes
    Provider.of<ProviderNavigationDrawer>(context, listen: false)
        .rebuildDestinations(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: destinations);
  }
}

class ProviderNavigationDrawer extends ChangeNotifier {
  var destinations = List.of([
    const SelectedDestination(
        index: 0,
        route: RouteEstudiantes(),
        text: "Estudiantes",
        icon: Icons.person_2),
    UnselectedDestination(
        index: 1,
        route: const RouteCarreras(),
        text: "Carreras",
        icon: Icons.view_list_outlined)
  ]);

  rebuildDestinations(int indexOfSelected) {
    for (int i = 0; i < destinations.length; i++) {
      var element = destinations[i];
      destinations[i] = UnselectedDestination(
          index: i,
          route: element.route,
          text: element.text,
          icon: element.icon);
    }
    var selected = destinations[indexOfSelected];
    destinations[indexOfSelected] = SelectedDestination(
        index: indexOfSelected,
        route: selected.route,
        text: selected.text,
        icon: selected.icon);
    notifyListeners();
  }
}

class Destination extends StatefulWidget {
  final int index;
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
    required this.index,
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
        // set screen
        Provider.of<ProviderCurrentScreen>(context, listen: false)
            .setCurrentScreen(widget.route),
        // set index
        Provider.of<ProviderCurrentScreen>(context, listen: false)
            .setCurrentIndex(widget.index),
        // rebuild destinations
        Provider.of<ProviderNavigationDrawer>(context, listen: false)
            .rebuildDestinations(widget.index)
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
  UnselectedDestination({
    super.key,
    required super.index,
    required super.route,
    required super.text,
    required super.icon,
  }) : super(
            backgroundColor: Colors.transparent,
            textColor: Colors.deepOrange,
            iconColor: Colors.deepOrange,
            hoverColor: Colors.deepOrange.shade50,
            exitHoverColor: Colors.transparent);
}

class SelectedDestination extends Destination {
  const SelectedDestination(
      {super.key,
      required super.index,
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
