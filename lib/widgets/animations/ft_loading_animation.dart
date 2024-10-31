import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:widgets_gallery/widgets/animations/arc_painter.dart';

class FTLoadingAnimation extends StatefulWidget {
  const FTLoadingAnimation({
    super.key,
    this.arcColor,
    this.duration = const Duration(seconds: 1),
    this.size = const Size(24, 24),
    this.sweepAngle = math.pi * 2,
    this.strokeWidth = 4,
    this.gradient,
  });

  final Color? arcColor;
  final Duration duration;
  final Size size;
  final double sweepAngle;
  final double strokeWidth;
  final SweepGradient? gradient;

  @override
  State<FTLoadingAnimation> createState() => _FTLoadingAnimationState();
}

class _FTLoadingAnimationState extends State<FTLoadingAnimation>
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
      duration: widget.duration,
    );

    _rotationAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _rotationAnimation,
        child: CustomPaint(
          size: widget.size,
          painter: ArcPainter(
            color: widget.arcColor ?? Colors.purple,
            startAngle: 0,
            sweepAngle: widget.sweepAngle,
            strokeWidth: widget.strokeWidth,
            gradient: widget.gradient ?? gradient,
          ),
        ),
      ),
    );
  }
}
