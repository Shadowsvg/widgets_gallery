import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:widgets_gallery/widgets/animations/arc_painter.dart';

class ArcAnimation extends StatefulWidget {
  const ArcAnimation({
    super.key,
    this.backgroundColor,
    this.arcColor,
    this.duration = const Duration(seconds: 1),
    this.size = const Size(24, 24),
    this.sweepAngle = math.pi / 2,
    this.strokeWidth = 4,
  });
  final Color? backgroundColor;
  final Color? arcColor;
  final Duration duration;
  final Size size;
  final double sweepAngle;
  final double strokeWidth;

  @override
  State<ArcAnimation> createState() => _ArcAnimationState();
}

class _ArcAnimationState extends State<ArcAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0, end: math.pi * 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CustomPaint(
            size: widget.size,
            painter: ArcPainter(
              color: widget.backgroundColor ??
                  Colors.purple.shade500.withOpacity(0.2),
              startAngle: 0,
              sweepAngle: math.pi * 2,
              strokeWidth: widget.strokeWidth,
            ),
          ),
          CustomPaint(
            size: widget.size,
            painter: ArcPainter(
              color: widget.arcColor ?? Colors.purple,
              startAngle: _animation.value,
              sweepAngle: widget.sweepAngle,
              strokeWidth: widget.strokeWidth,
            ),
          ),
        ],
      ),
    );
  }
}
