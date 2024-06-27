import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_current_screen.dart';
import '../screen/route_carreras.dart';
import '../screen/route_estudiantes.dart';

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({
    super.key,
  });

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  var routes = List<Widget>.empty();

  @override
  void initState() {
    super.initState();
    routes = [const RouteEstudiantes(), const RouteCarreras()];
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        backgroundColor: Colors.deepOrange,
        onDestinationSelected: (int index) {
          setState(() {
            Provider.of<ProviderCurrentScreen>(context, listen: false)
                .setCurrentIndex(index);
            Provider.of<ProviderCurrentScreen>(context, listen: false)
                .setCurrentScreen(routes[index]);
          });
        },
        indicatorColor: Colors.deepOrange[800],
        selectedIndex: Provider.of<ProviderCurrentScreen>(context, listen: true)
            .currentIndex,
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
        ]);
  }
}
