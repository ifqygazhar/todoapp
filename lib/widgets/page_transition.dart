import 'package:flutter/material.dart';

class PageTransitionWidget {
  static PageRouteBuilder slideFromRight(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var curveTween = CurveTween(curve: Curves.easeInOut);

        var tween = Tween(begin: begin, end: end).chain(curveTween);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
