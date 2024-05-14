import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void displaySuccessSnackbar(ScaffoldMessengerState sm, String message) {
  sm.showSnackBar(
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

void displayLoadingSnackbar(ScaffoldMessengerState sm, String message) {
  sm.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
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
