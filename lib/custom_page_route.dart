import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget route;

  CustomPageRoute({required this.route})
      : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              route,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fadeTransition = Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation);
            return FadeTransition(
              opacity: fadeTransition,
              child: child,
            );
          },
        );
}
