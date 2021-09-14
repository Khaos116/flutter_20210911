import 'package:flutter/material.dart';

class Transitions {
  static SlideTransition createTransition(Animation<double> animation, Widget child) {
    SlideTransition slideTransition = SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
    return slideTransition;
  }
}
