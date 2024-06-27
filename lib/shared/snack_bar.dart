import 'package:app_material_3/main.dart';
import 'package:app_material_3/provider/provider_current_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../model/estudiante.dart';
import '../screen/route_detail_estudiante.dart';

void displaySuccessSnackbar(String message) {
  snackbarKey.currentState!.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      content: Animate(
        effects: const [SlideEffect(), FadeEffect()],
        child: Row(
          children: <Widget>[
            Icon(
              size: 30,
              Icons.check_circle_rounded,
              color: Colors.green[400],
            ),
            Container(
                margin: const EdgeInsets.only(left: 15), child: Text(message)),
          ],
        ),
      ),
    ),
  );
}

void displaySnackbarEstudianteCreado(Estudiante estudianteCreado) {
  snackbarKey.currentState!.showSnackBar(
    SnackBar(
      action: SnackBarAction(
          label: "Ver",
          onPressed: () => {
                Provider.of<ProviderCurrentScreen>(snackbarKey.currentContext!,
                        listen: false)
                    .setCurrentScreen(RouteDetailEstudiante(estudianteCreado)),
                ScaffoldMessenger.of(navKey.currentContext!)
                    .hideCurrentSnackBar()
              }),
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      content: Animate(
        effects: const [SlideEffect(), FadeEffect()],
        child: Row(
          children: <Widget>[
            Icon(
              size: 30,
              Icons.check_circle_rounded,
              color: Colors.green[400],
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: const Text("Estudiante agregado!"),
            ),
          ],
        ),
      ),
    ),
  );
}

navigateTo(RouteDetailEstudiante routeDetailEstudiante) {
  navKey.currentState?.push(PageTransition(
    child: routeDetailEstudiante,
    type: PageTransitionType.rightToLeft,
  ));
}

void displayErrorSnackbar(String message) {
  snackbarKey.currentState!.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      content: Animate(
        effects: const [SlideEffect(), FadeEffect()],
        child: Row(
          children: <Widget>[
            const Icon(
              size: 30,
              Icons.error_rounded,
              color: Colors.red,
            ),
            Container(
                margin: const EdgeInsets.only(left: 15), child: Text(message)),
          ],
        ),
      ),
    ),
  );
}

void displayLoadingSnackbar(String message) {
  snackbarKey.currentState!.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: <Widget>[
          const Center(
              child: SizedBox(
                  height: 25, width: 25, child: CircularProgressIndicator())),
          Container(
              margin: const EdgeInsets.only(left: 15), child: Text(message)),
        ],
      ),
    ),
  );
}
