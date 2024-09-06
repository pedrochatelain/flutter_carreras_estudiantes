import 'package:app_material_3/provider/provider_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_material_3/provider/provider_estudiantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/provider_carreras.dart';
import 'provider/provider_current_screen.dart';
import 'screen/route_login.dart';
import 'shared/bottom_navigation_bar.dart' as bottom_nav;
import 'shared/desktop_navigation_drawer.dart';
import 'shared/main_speed_dial.dart';

final snackbarKey = GlobalKey<ScaffoldMessengerState>();
final navKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderEstudiantes(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderCarreras(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderCurrentScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderNavigationDrawer(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderLogin(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navKey,
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(),
          navigationBarTheme: const NavigationBarThemeData(
              iconTheme:
                  WidgetStatePropertyAll(IconThemeData(color: Colors.white)),
              labelTextStyle:
                  WidgetStatePropertyAll(TextStyle(color: Colors.white))),
          useMaterial3: true,
        ),
        home: const RouteLogin(),
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
  bool hasTabletOrPhoneWidth = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    hasTabletOrPhoneWidth = MediaQuery.sizeOf(context).width < 600;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const MainSpeedDial(),
        bottomNavigationBar: hasTabletOrPhoneWidth
            ? const bottom_nav.BottomNavigationBar()
            : null,
        body: hasTabletOrPhoneWidth
            ? Provider.of<ProviderCurrentScreen>(context, listen: true)
                .currentScreen
            : Row(
                children: [
                  const DesktopNavigationDrawer(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Provider.of<ProviderCurrentScreen>(context,
                              listen: true)
                          .currentScreen,
                    ),
                  )
                ],
              )
        // appBar: AppBar(),
        );
  }
}
