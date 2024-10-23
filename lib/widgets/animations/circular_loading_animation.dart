import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:widgets_gallery/widgets/animations/arc_painter.dart';

class CircularLoadingAnimation extends StatefulWidget {
  const CircularLoadingAnimation({super.key});

  @override
  State<CircularLoadingAnimation> createState() =>
      _CircularLoadingAnimationState();
}

class _CircularLoadingAnimationState extends State<CircularLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  final gradient = SweepGradient(
    colors: [
      Colors.purple.shade500,
      Colors.white,
      Colors.white,
      Colors.purple.shade500,
    ],
    stops: const [0.0, 0.40, 0.70, 1.0],
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _rotationAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          turns: _rotationAnimation,
          child: CustomPaint(
            size: const Size(50, 50),
            painter: ArcPainter(
              color: Colors.purple,
              startAngle: 0,
              sweepAngle: math.pi * 2,
              isBackground: true,
              strokeWidth: 8,
              gradient: gradient,
            ),
          ),
        ),
      ),
    );
  }
}
